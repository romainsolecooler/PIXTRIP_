import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class AddPhoto extends StatefulWidget {
  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File _image;
  Position _position;
  CompassEvent _lastRead;

  final _picker = ImagePicker();

  Future getImage() async {
    print('getting image');

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    print(position.altitude);

    final pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      print('settin_state');
      setState(() {
        _image = File(pickedFile.path);
        _position = position;
        //_lastRead = tmp;
        c.setAddTripImage(_image);
        c.setAddLatitude(position.latitude);
        c.setAddLongitude(position.longitude);
        c.setAddAltitude(position.altitude);
      });
    } else {
      print('no image selected');
    }
  }

  Widget addPhotoButton() {
    return ElevatedButton.icon(
      onPressed: () => getImage(),
      icon: Icon(Icons.add),
      label: Text('add_trip__add_photo'.tr),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget background = _image != null
        ? Image.file(
            _image,
            fit: BoxFit.cover,
          )
        : Container(color: Colors.grey[300]);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        width: Get.width * 0.8,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              background,
              Align(child: addPhotoButton()),
            ],
          ),
        ),
      ),
    );
  }
}
