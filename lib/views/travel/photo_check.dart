import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/travel/compass_navigation_bar.dart';
import 'package:pixtrip/components/travel/photo.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/fail.dart';
import 'package:pixtrip/views/travel/success.dart';

Controller c = Get.find();

class PhotoCheck extends StatefulWidget {
  @override
  _PhotoCheckState createState() => _PhotoCheckState();
}

class _PhotoCheckState extends State<PhotoCheck> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      print('salut');
      print(c.tripImage.value);
      final image = MultipartFile(c.photoPath.value, filename: 'image');
      c.checkHttpResponse(
          url: 'trip/check_photo.php',
          data: FormData({
            'image': image,
            'trip_image': c.tripImage.value,
          }),
          loading: () => null,
          error: () => null,
          callBack: (data) {
            print(data);
            if (data['message'] == true) {
              Get.offAll(() => Success());
            } else {
              Get.offAll(() => Fail());
            }
          });
    });
  }

  @override
  void dispose() {
    print('au revoir');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
          child: Column(
            children: [
              Photo(opacity: false),
              SizedBox(height: 25.0),
              CircularProgressIndicator.adaptive(),
              _DevChoice(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CompassNavigationBar(),
    );
  }
}

class _DevChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => Get.offAll(() => Success()),
          child: Text('Succes'),
        ),
        ElevatedButton(
          onPressed: () => Get.offAll(() => Fail()),
          child: Text('Fail'),
        )
      ],
    );
  }
}
