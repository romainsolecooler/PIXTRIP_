import 'dart:async';
import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/capture_modes.dart';
import 'package:camerawesome/models/flashmodes.dart';
import 'package:camerawesome/models/sensors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:pixtrip/common/utils.dart';
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
  StreamSubscription<Position> _stream;

  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _stream = Geolocator.getPositionStream().listen((position) {
      setState(() => _position = position);
    });
  }

  @override
  void dispose() {
    _stream.cancel();
    super.dispose();
  }

  void getImage() async {
    File image;
    image = await Get.to(
      TakePhotoScreen(),
      fullscreenDialog: true,
    );
    var position = await Geolocator.getCurrentPosition();
    logger.d(image);
    logger.i(position);
    setState(() {
      _image = image;
    });
    c.setAddTripImage(_image);
    c.setAddLatitude(position.latitude);
    c.setAddLongitude(position.longitude);
    return;
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
      });
    } else {
      print('no image selected');
    }
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
              Align(
                child: ElevatedButton.icon(
                  onPressed: () => getImage(),
                  icon: Icon(Icons.add),
                  label: Text('add_trip__add_photo'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TakePhotoScreen extends StatelessWidget {
  TakePhotoScreen({Key key}) : super(key: key);

  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.PHOTO);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);

  // Controllers
  PictureController _pictureController = new PictureController();
  VideoController _videoController = new VideoController();

  void takePhoto() async {
    final Directory extDir = await getTemporaryDirectory();
    final testDir =
        await Directory('${extDir.path}/test').create(recursive: true);
    final String filePath =
        '${testDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await _pictureController.takePicture(filePath);
    final file = File(filePath);
    Get.back(result: file);
  }

  Future<void> load() async {
    await Future.delayed(Duration(milliseconds: 300));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: takePhoto,
          child: Icon(Icons.photo_camera),
          tooltip: 'travel__take_photo'.tr,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: FutureBuilder(
          future: load(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Stack(
              alignment: Alignment.topRight,
              children: [
                CameraAwesome(
                  testMode: false,
                  selectDefaultSize: (List<Size> availableSizes) =>
                      Size(1920, 1080),
                  sensor: _sensor,
                  photoSize: _photoSize,
                  switchFlashMode: _switchFlash,
                  captureMode: _captureMode,
                  orientation: DeviceOrientation.portraitUp,
                  fitted: false,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.7),
                  ),
                  child: IconButton(
                    onPressed: Get.back,
                    icon: Icon(Icons.close),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
