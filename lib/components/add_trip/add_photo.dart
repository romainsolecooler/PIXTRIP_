import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => print('add photo'),
      icon: Icon(Icons.add),
      label: Text('add_trip__add_photo'.tr),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        )),
      ),
    );
  }
}
