import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/profil/profil_details.dart';

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
                  CircleAvatar(),
                  SizedBox(width: 15.0),
                  Text(
                    c.userPseudo.value,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(child: SizedBox()),
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

class ProfilList extends StatelessWidget {
  final double _spacing = 15.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2 - 20;
    int max = 51;

    List<Widget> children = [];

    for (int i = 0; i < max; i++) {
      children.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: screenWidth,
          height: screenWidth,
          child: InkWell(
            onTap: () => print('show trip from profil'),
            child: Placeholder(),
          ),
        ),
      ));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          children: children,
          spacing: _spacing,
          runSpacing: _spacing,
        ),
      ),
    );
  }
}
