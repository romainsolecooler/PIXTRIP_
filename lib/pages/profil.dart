import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/bindings/profil_binding.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/profil/user_image.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/profil/profil_details.dart';
import 'package:pixtrip/views/travel/trip_details.dart';

//Controller c = Get.find();

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              /* Obx(
                () => CircleAvatar(
                  backgroundImage: NetworkImage(c.userImage.value),
                  radius: 35.0,
                ),
              ), */
              UserImage(isEditable: false),
              SizedBox(width: 15.0),
              Expanded(
                child: Obx(
                  () => Text(
                    c.userPseudo.value,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => Get.to(
                  () => ProfilDetails(),
                  binding: ProfilBinding(),
                ),
              ),
            ],
          ),
        ),
        ProfilList(),
      ],
    );
  }
}

class ProfilList extends StatelessWidget {
  final double _spacing = 15.0;
  final Controller c = Get.find();

  Future<List<dynamic>> getProfilTrips() async {
    print('getting profile trips');
    var response = await dio.post(
      'trip/get_profil_trips.php',
      data: {'user_id': c.userId.value},
    );
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProfilTrips(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('error_title'.tr);
          }
          List<_Element> children = [];
          for (final item in snapshot.data) {
            children.add(_Element(element: item));
          }
          if (children.length <= 0) {
            return Text('profil__empty_list'.tr);
          }
          return Expanded(
            child: Wrap(
              spacing: _spacing,
              runSpacing: _spacing,
              children: children,
            ),
          );
        }
        return CircularProgressIndicator.adaptive();
      },
    );
  }
}

class _Element extends StatelessWidget {
  final Map<String, dynamic> element;

  final Controller c = Get.find();

  _Element({
    Key key,
    @required this.element,
  }) : super(key: key);

  void onTap() {
    c.setTrip(element);
    c.setFinishedTrip(false);
    Get.to(() => TripDetails());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2 - 20;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: width,
        height: width,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(10.0),
          child: LoadImageWithLoader(
            url: 'trips/${element['image']}',
            blurred: false,
          ),
        ),
      ),
    );
  }
}
