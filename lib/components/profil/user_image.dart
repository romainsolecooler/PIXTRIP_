import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixtrip/common/utils.dart';

import 'package:pixtrip/controllers/controller.dart';

const radius = 35.0;
const parentSize = radius * 2;

class UserImage extends StatelessWidget {
  final bool isEditable;

  const UserImage({Key key, this.isEditable = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller c = g.Get.find();
    return Container(
      width: parentSize,
      height: parentSize,
      child: Center(
        child: g.Obx(() {
          return c.loadingUserImage.value
              ? CircularProgressIndicator.adaptive()
              : isEditable
                  ? TapableUserImage()
                  : NotTapableUserImage();
        }),
      ),
    );
  }
}

class NotTapableUserImage extends StatelessWidget {
  const NotTapableUserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller c = g.Get.find();
    return g.Obx(() => LoadUserImage(
          url: c.userImage.value,
        ));
  }
}

class TapableUserImage extends StatelessWidget {
  const TapableUserImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller c = g.Get.find();
    return GestureDetector(
      onTap: () => g.Get.bottomSheet(SelectImageSource()),
      child: Stack(
        alignment: Alignment.center,
        children: [
          g.Obx(
            () => LoadUserImage(
              url: c.userImage.value,
            ),
          ),
          ChangeImage(),
        ],
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

class SelectImageSource extends StatelessWidget {
  const SelectImageSource({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'image_picker__title'.tr,
            style: g.Get.context.textTheme.headline6,
          ),
          SizedBox(height: 30.0),
          Row(children: [
            SourceChoice(
              text: 'image_picker__camera',
              icon: Icons.camera,
              imageSource: ImageSource.camera,
            ),
            SizedBox(width: 25.0),
            SourceChoice(
              text: 'image_picker__gallery',
              icon: Icons.photo,
              imageSource: ImageSource.gallery,
            ),
          ]),
        ],
      ),
    );
  }
}

class SourceChoice extends StatelessWidget {
  final String text;
  final IconData icon;
  final ImageSource imageSource;
  final picker = ImagePicker();

  SourceChoice({Key key, this.text, this.icon, this.imageSource})
      : super(key: key);

  void getImage() async {
    print('getting image');
    print(imageSource);
    final pickedFile = await picker.getImage(
      source: imageSource,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      sendImage(File(pickedFile.path));
    } else {
      print('no file selected');
    }
  }

  void sendImage(File file) async {
    c.setLoadingUserImage(true);
    g.Get.back();
    print('sending image');
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path, filename: 'image'),
      'u_id': c.userId.value,
    });
    var response = await dio.post('user/change_photo.php', data: formData);
    var data = response.data;
    logger.d(data);
    if (data['error'] != null) {
      g.Get.defaultDialog(
        title: 'error_title'.tr,
        content: Text(
          'profil__error_change_image'.tr,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      c.setUserImage(data['image']);
    }
    c.setLoadingUserImage(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: getImage,
      child: Column(
        children: [
          Text(text.tr),
          Icon(
            icon,
            size: 80.0,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
