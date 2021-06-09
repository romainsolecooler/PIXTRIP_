import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

var dio = Dio(BaseOptions(
  baseUrl: 'https://pixtrip.fr/api/',
));
var logger = Logger();

class LoadImageWithLoader extends StatelessWidget {
  final String url;
  final bool blurred;

  const LoadImageWithLoader({
    Key key,
    this.url,
    this.blurred = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sigma = blurred ? 5.0 : 0.0;

    return CachedNetworkImage(
      imageUrl: 'https://pixtrip.fr/images/$url',
      placeholder: (context, url) => Center(child: LinearProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: (context, imageProvider) {
        return Stack(
          children: [
            Image(
              image: imageProvider,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      fadeOutDuration: Duration.zero,
    );
  }
}

class LoadAssetsImage extends StatelessWidget {
  final String source;

  const LoadAssetsImage({Key key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      source,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class LoadUserImage extends StatelessWidget {
  final String url;

  const LoadUserImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != ''
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image(
                  image: imageProvider,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
            fadeOutDuration: Duration.zero,
          )
        : CircleAvatar(
            child: Text(
              c.userPseudo.value[0].toUpperCase(),
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            radius: double.infinity,
          );
  }
}

void checkPermissions({Function success, Function callBack}) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.photos,
  ].request();
  bool _permission = true;
  statuses.forEach((key, value) {
    if (value != PermissionStatus.granted) {
      print(key);
      print(value);
      _permission = false;
    }
  });
  if (!_permission) {
    callBack();
    return;
  }
  success();
  return;
}
