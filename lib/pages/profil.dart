import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/components/profil/user_image.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/profil/profil_details.dart';
import 'package:pixtrip/views/travel/trip_details.dart';

Controller c = Get.find();

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Obx(
                    () => CircleAvatar(
                      backgroundImage: NetworkImage(c.userImage.value),
                      radius: 35.0,
                    ),
                  ),
                  // UserImage(isEditable: false),
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
                    onPressed: () =>
                        pushNewScreen(context, screen: ProfilDetails()),
                  ),
                ],
              ),
            ),
            ProfilList(),
          ],
        ),
      ),
    );
  }
}

class ProfilList extends StatefulWidget {
  @override
  _ProfilListState createState() => _ProfilListState();
}

class _ProfilListState extends State<ProfilList> {
  final double _spacing = 15.0;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    print('init profil state');
    c.checkHttpResponse(
        url: 'trip/get_profil_trips.php',
        data: {'user_id': c.userId.value},
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          c.setProfilList(data);
          setState(() => _loading = false);
        });
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator.adaptive()
        : Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                if (c.profilList.length == 0) {
                  return Text('profil__empty_list'.tr);
                }
                return Wrap(
                  children: c.profilList.map((element) {
                    return _Element(element: element);
                  }).toList(),
                  spacing: _spacing,
                  runSpacing: _spacing,
                );
              }),
            ),
          );
  }
}

class _Element extends StatelessWidget {
  final Map<String, dynamic> element;

  const _Element({
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
