import 'package:get/get.dart';

class SettingsController extends GetxController {
  final difficultyList = <Chip>[
    Chip(label: 'difficulty_picker__0'.tr, value: 0),
    Chip(label: 'difficulty_picker__1'.tr, value: 1),
    Chip(label: 'difficulty_picker__2'.tr, value: 2),
  ];

  final categoryList = <Chip>[
    Chip(label: 'cultural', value: 0),
    Chip(label: 'architectural', value: 1),
    Chip(label: 'point_of_view', value: 2),
    Chip(label: 'artistic', value: 3),
    Chip(label: 'flora_and_fauna', value: 4),
    Chip(label: 'unusual', value: 5),
    Chip(label: 'instagrammable', value: 6),
  ];

  final cityName = ''.obs;
  final currentPosition = false.obs;
  final showUrban = false.obs;
  final showCountry = false.obs;
  final distanceSlider = 4.obs;
  final difficultyPicker = <int>[].obs;
  final categoryPicker = <int>[].obs;
}

class Chip {
  final String label;
  final int value;

  Chip({this.label, this.value});
}
