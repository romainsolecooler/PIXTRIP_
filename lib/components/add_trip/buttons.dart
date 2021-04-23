import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class AddTripButton extends StatefulWidget {
  @override
  _AddTripButtonState createState() => _AddTripButtonState();
}

class _AddTripButtonState extends State<AddTripButton> {
  bool _loading = false;

  void addTrip() {
    print('add trip');
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
