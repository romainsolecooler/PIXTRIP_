import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_widget/image_picker_widget.dart';

import 'package:pixtrip/controllers/controller.dart';

const radius = 35.0;
const parentSize = radius * 2;

Controller c = Get.find();

class UserImage extends StatelessWidget {
  final bool isEditable;

  const UserImage({Key key, this.isEditable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ImagePickerWidget(
        initialImage: c.userImage.value != '' ? c.userImage.value : null,
        diameter: parentSize,
        isEditable: isEditable,
        editIcon: ChangeImage(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        modalTitle: Text('image_picker__title'.tr),
        modalCameraText: Text('image_picker__camera'.tr),
        modalGalleryText: Text('image_picker__gallery'.tr),
        onChange: (File file) {
          print(c.userId.value);
          final avatar = MultipartFile(file, filename: 'image');
          c.checkHttpResponse(
            url: 'user/change_photo.php',
            data: FormData({
              'image': avatar,
              'u_id': c.userId.value,
            }),
            loading: () => null,
            error: () => null,
            callBack: (data) {
              c.setUserImage(data['image']);
            },
          );
        },
      ),
    );
  }
}

class ChangeImage extends StatelessWidget {
  final BorderRadius _borderRadius = BorderRadius.circular(50.0);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.25, 1.25),
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: Colors.grey[300],
        ),
        child: Icon(
          Icons.photo_camera,
          size: 20,
        ),
      ),
    );
  }
}
