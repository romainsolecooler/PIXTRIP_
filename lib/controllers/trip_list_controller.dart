import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/settings_controller.dart';

class TripListController extends GetxController {
  final loading = false.obs;
  final freezedList = <dynamic>[].obs;
  final tripList = <dynamic>[].obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  @override
  void onInit() {
    logger.d('inited trips list');
    getAllTrips();
    super.onInit();
  }

  @override
  void onClose() {
    print('close trips list');
    super.onClose();
  }

  void getAllTrips() async {
    loading(true);
    print('getting trip list');
    var pos = await Geolocator.getCurrentPosition();
    var response = await dio.post('trip/get_all_trips.php', data: {});
    tripList.value = response.data;
    freezedList.value = response.data;
    latitude(pos.latitude);
    longitude(pos.longitude);
    loading(false);
  }

  void orderTrips() async {
    loading(true);
    Position currentPosition;
    SettingsController settingsController = Get.find();
    String city = settingsController.cityName().trim().toLowerCase();
    bool showCurrentPosition = settingsController.currentPosition();
    bool showUrban = settingsController.showUrban();
    bool showCountry = settingsController.showCountry();
    List<int> difficulty = settingsController.difficultyPicker;
    List<String> category = settingsController.categoryPicker
        .map((e) => settingsController.categoryList[e].label)
        .toList();
    int distance = settingsController.distanceSlider();
    List<double> distanceList = [
      5000.0,
      10000.0,
      20000.0,
      50000.0,
    ];
    currentPosition = city == '' || showCurrentPosition
        ? distance == 4
            ? null
            : await Geolocator.getCurrentPosition()
        : null;
    List<dynamic> temp = []
      ..addAll(freezedList)
      ..removeWhere((item) {
        if (!showCurrentPosition) {
          if (city != '' && !item['city'].toLowerCase().contains(city)) {
            return true;
          }
        }
        if ((showUrban && !showCountry) || (!showUrban && showCountry)) {
          String removeIndex = showUrban ? 'urban' : 'country';
          if (item['environment'] != removeIndex) {
            return true;
          }
        }
        if (difficulty.length != 0) {
          if (!difficulty.contains(item['difficulty'])) {
            return true;
          }
        }
        if (category.length != 0) {
          if (!category.contains(item['category'])) {
            return true;
          }
        }
        if (city == '' || showCurrentPosition) {
          if (distance == 4) {
            return false;
          } else {
            latitude(currentPosition.latitude);
            longitude(currentPosition.longitude);
            double distanceToTrip = Geolocator.distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              item['latitude'],
              item['longitude'],
            );
            if (distanceToTrip > distanceList[distance]) {
              return true;
            }
          }
        }
        return false;
      });
    //temp.removeWhere((item) => item['to_delete'] != null && item['to_delete']);
    tripList(temp);
    loading(false);
  }
}
