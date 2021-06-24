import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/trip_list_controller.dart';
import 'package:pixtrip/pages/travel.dart';
import 'package:pixtrip/views/travel/trip_details.dart';

Controller c = Get.find();

class TripsList extends StatelessWidget {
  final double _spacing = 15.0;
  final TripListController tripListController = Get.put(TripListController());

  Future<List<dynamic>> getTripsList() async {
    print('getting all trips');
    var response = await dio.post('trip/get_all_trips.php', data: {});
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.tripSelectedFromHome.value) {
        Future.delayed(Duration.zero, () {
          Get.dialog(Trip(), barrierColor: Colors.transparent);
          c.setTripSelectedFromHome(false);
        });
      }
      return tripListController.loading.value
          ? CircularProgressIndicator.adaptive()
          : Wrap(
              spacing: _spacing,
              runSpacing: _spacing,
              children: tripListController.tripList.map((element) {
                return Element(element: element);
              }).toList(),
            );
    });
    /* return _loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : SingleChildScrollView(
            child: Obx(
              () {
                if (c.tripSelectedFromHome.value) {
                  Future.delayed(Duration.zero, () {
                    Get.dialog(Trip(), barrierColor: Colors.transparent);
                    c.setTripSelectedFromHome(false);
                  });
                }
                return Wrap(
                  spacing: _spacing,
                  runSpacing: _spacing,
                  children: c.tripsList.map((element) {
                    return Element(element: element);
                  }).toList(),
                );
              },
            ),
          ); */
  }
}

class Element extends StatelessWidget {
  final Map<String, dynamic> element;

  const Element({
    Key key,
    @required this.element,
  }) : super(key: key);

  void onTap() {
    c.setTrip(element);
    Get.dialog(
      Trip(),
      barrierColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2 - 20;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: screenWidth,
        height: screenWidth,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(10),
          child: LoadImageWithLoader(
            url: 'trips/${element['image']}',
            blurred: true,
            fromAdmin: element['from_admin'],
          ),
        ),
      ),
    );
  }
}

class Trip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(25.0),
          width: Get.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  width: Get.width * 0.8,
                  height: Get.height * 0.25,
                  child: LoadImageWithLoader(
                    url: 'trips/${c.tripImage.value}',
                    blurred: true,
                    fromAdmin: c.tripFromAdmin.value,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                c.tripCity.value,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 30.0),
              Text('slider__distance_${c.tripDistance.value}'.tr),
              _CustomDivider(),
              Text('slider__time_${c.tripTime.value}'.tr),
              _CustomDivider(),
              Text('slider__difficulty_${c.tripDifficulty.value}'.tr),
              SizedBox(height: 30.0),
              _GoButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        c.setPositionList([]);
        Get.offAll(() => PixtripMap());
      },
      child: Text('trips__go'.tr),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      indent: 75,
      endIndent: 75,
    );
  }
}
