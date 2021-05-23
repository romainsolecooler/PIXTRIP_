import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class Photo extends StatelessWidget {
  final bool opacity;

  const Photo({Key key, @required this.opacity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double photoSize = Get.width * 0.8;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        width: photoSize,
        height: photoSize,
        child: Opacity(
          opacity: opacity ? 1 : 0.3,
          child: Obx(() => Image.file(
                File(
                  c.photoPath.value,
                ),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
