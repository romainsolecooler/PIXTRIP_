import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class TripsList extends StatefulWidget {
  @override
  _TripsListState createState() => _TripsListState();
}

class _TripsListState extends State<TripsList> {
  bool _loading = false;

  double _spacing = 15.0;

  @override
  void initState() {
    super.initState();
    c.checkHttpResponse(
        url: 'trip/get_all_trips.php',
        data: {},
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          c.setTripsList(data);
          setState(() => _loading = false);
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2 - 20;

    List<Widget> children = [];

    for (int i = 0; i < c.tripsList.length; i++) {
      final item = c.tripsList[i];
      String imageUrl = 'https://pixtrip.fr/images/trips/${item['image']}';
      children.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: screenWidth,
          height: screenWidth,
          child: InkWell(
            onTap: () => Get.dialog(
              Trip(),
              barrierColor: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
            child: LoadImageWithLoader(
              url: imageUrl,
              blurred: true,
            ),
          ),
        ),
      ));
    }

    return _loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : SingleChildScrollView(
            child: Wrap(
              spacing: _spacing,
              runSpacing: _spacing,
              children: children,
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
                child: Placeholder(
                  fallbackHeight: 200.0,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Perpignan',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 30.0),
              Text('Distance : 5 km'),
              _CustomDivider(),
              Text('Temps : entre 1h et 2h'),
              _CustomDivider(),
              Text('Difficulté : Ok avec de la motivation'),
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
      onPressed: () => print('faire le trip'),
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
