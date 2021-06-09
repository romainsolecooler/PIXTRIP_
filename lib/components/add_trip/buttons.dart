import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;

import 'package:pixtrip/controllers/controller.dart';

Controller c = g.Get.find();

class AddTripButton extends StatefulWidget {
  @override
  _AddTripButtonState createState() => _AddTripButtonState();
}

class _AddTripButtonState extends State<AddTripButton> {
  bool _loading = false;

  void addTrip() async {
    if (c.addTripImage.value.path == '' ||
        c.addLatitude.value == 0.0 ||
        c.addLongitude.value == 0.0 ||
        c.addAltitude.value == 0.0 ||
        c.addFirstInfo.value == '' ||
        c.addSecondInfo.value == '' ||
        c.addCityName.value == '') {
      g.Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text('add_trip__empty_form'.tr),
      );
      return;
    }
    setState(() {
      _loading = true;
    });
    print(c.addLatitude.value);
    print(c.addLongitude.value);
    print(c.addAltitude.value);
    //final image = MultipartFile(c.addTripImage.value, filename: 'image');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(c.addTripImage.value.path),
      'user_id': c.userId.value,
      'city': c.addCityName.value,
      'distance': c.addDistance.value,
      'time': c.addTime.value,
      'difficulty': c.addDifficulty.value,
      'latitude': c.addLatitude.value,
      'longitude': c.addLongitude.value,
      'altitude': c.addAltitude.value,
      'anecdote_1': c.addFirstInfo.value,
      'anecdote_2': c.addSecondInfo.value,
      'anecdote_3': c.addThirdInfo.value,
    });
    var response = await Dio()
        .post('https://pixtrip.fr/api/trip/add_trip.php', data: formData);
    print(response.data['message']);
    setState(() {
      _loading = false;
    });
    var data = response.data;
    if (data['error']) {
      g.Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text(data['message']),
      );
    } else {
      g.Get.defaultDialog(
        title: 'sucess_title'.tr,
        content: Text(
          'add_trip__sucess'.tr,
        ),
      );
      c.deletedAddTripInfos();
      c.goToPage(index: 0);
      c.setAppBarController(0);
    }
    return;
    //final image = MultipartFile(c.addTripImage.value, filename: 'image');
    /* c.checkHttpResponse(
        url: 'trip/add_trip.php',
        data: FormData({
          'image': image,
          'user_id': c.userId.value,
          'city': c.addCityName.value,
          'distance': c.addDistance.value,
          'time': c.addTime.value,
          'difficulty': c.addDifficulty.value,
          'latitude': c.addLatitude.value,
          'longitude': c.addLongitude.value,
          'altitude': c.addAltitude.value,
          'anecdote_1': c.addFirstInfo.value,
          'anecdote_2': c.addSecondInfo.value,
          'anecdote_3': c.addThirdInfo.value,
        }),
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          setState(() => _loading = false);
          Get.defaultDialog(
            title: 'sucess_title'.tr,
            content: Text(data['message']),
          );
        }); */
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? CircularProgressIndicator.adaptive()
        : ElevatedButton(
            child: Text('add_trip_add_button'.tr),
            onPressed: () => addTrip(),
          );
  }
}
