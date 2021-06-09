import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key key}) : super(key: key);

  List<BottomNavigationBarItem> _buildBottomItems(context) {
    Map<String, IconData> tabIcons = {
      'app__home': Icons.home,
      'app__trip': Icons.place,
      'app__profil': Icons.person,
      'app__create_trip': Icons.add_location_alt,
      'app__wallet': Icons.folder
    };

    List<BottomNavigationBarItem> items = [];
    tabIcons.forEach((key, el) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(
            el,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          label: key.tr,
        ),
      );
    });
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      onTap: (index) {
        print(index);
        c.goToPage(index: index);
        print(c.currentIndex.value);
      },
      items: _buildBottomItems(context),
    );
  }
}
