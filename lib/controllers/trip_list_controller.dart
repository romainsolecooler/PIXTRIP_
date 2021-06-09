import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

import 'package:pixtrip/common/utils.dart';

class TripListController extends GetxController {
  final loading = false.obs;
  final freezedList = <dynamic>[].obs;
  final tripList = <dynamic>[].obs;

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
    var response = await dio.post('trip/get_all_trips.php', data: {});
    tripList.value = response.data;
    freezedList.value = response.data;
    loading(false);
  }

  void orderTrips({
    String city,
    bool currentPosition,
    int distance,
    int difficulty,
    int time,
  }) async {
    loading(true);
    String cleanedCity = city.trim().toLowerCase();
    List<dynamic> tempList = []
      ..addAll(freezedList)
      ..removeWhere(
        (item) => ((cleanedCity != '' &&
                !item['city'].toLowerCase().contains(cleanedCity)) ||
            item['distance'] != distance ||
            item['difficulty'] != difficulty ||
            item['time'] != time),
      );
    if (currentPosition) {
      Position position = await Geolocator.getCurrentPosition();
      Coordinates coordinates =
          Coordinates(position.latitude, position.longitude);
      List<Address> addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      Address first = addresses.first;
      String geocoderAdress = first.locality.toLowerCase();
      tempList.removeWhere(
          (item) => !item['city'].toLowerCase().contains(geocoderAdress));
    }
    tripList(tempList);
    loading(false);
  }
}
