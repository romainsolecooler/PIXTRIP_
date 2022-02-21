import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:latlong/latlong.dart';
import 'package:latlong2/latlong.dart';
import 'package:wakelock/wakelock.dart';
import 'package:pixtrip/bindings/compass_binding.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/travel/give_up_popup.dart';
import 'package:pixtrip/components/travel/pixtrip_map_bottom_bar.dart';
import 'package:pixtrip/components/travel/zone.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/compass.dart';

Controller c = Get.find();

class PixtripMap extends StatefulWidget {
  @override
  _PixtripMapState createState() => _PixtripMapState();
}

class _PixtripMapState extends State<PixtripMap> {
  double _latitude;
  double _longitude;
  double _zoom = c.tripEnvironment() == 'urban' ? 13.0 : 12.0;

  StreamSubscription<Position> _stream;

  double tripRadius = c.tripEnvironment.value == 'urban' ? 1000.0 : 2500.0;

  @override
  void initState() {
    super.initState();
    print('gonna wake lock');
    Wakelock.enable();
    _stream = Geolocator.getPositionStream().listen((position) {
      print('getting position');
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        c.tripLatitude.value,
        c.tripLongitude.value,
      );
      if (distance < tripRadius) {
        _stream.cancel();
        Get.offAll(() => Compass(), binding: CompassBinding());
      }
    });
  }

  @override
  void dispose() {
    print('dipose stream');
    _stream.cancel();
    super.dispose();
  }

  void _setZoom(zoom) {
    Future.delayed(Duration.zero, () {
      setState(() {
        _zoom = zoom;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    double iconSize = (tripRadius / 57465) * pow(2, _zoom); // en mètres
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(
          GiveUpPopup(),
          barrierColor: Colors.transparent,
        );
        return false;
      },
      child: Scaffold(
        appBar: appBar,
        body: _latitude != null && _longitude != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  FlutterMap(
                    options: MapOptions(
                      center:
                          LatLng(c.tripLatitude.value, c.tripLongitude.value),
                      zoom: _zoom,
                      maxZoom: 18.4,
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      /* onTap: (data) {
                        _stream.cancel();
                        Get.offAll(() => Compass());
                      }, */
                      onPositionChanged: (data, changed) => _setZoom(data.zoom),
                    ),
                    children: [
                      TileLayerWidget(
                        options: TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                      ),
                      LocationMarkerLayerWidget(
                        options: LocationMarkerLayerOptions(
                          marker: DefaultLocationMarker(
                            color: color,
                          ),
                          headingSectorColor: color.withOpacity(0.3),
                          accuracyCircleColor: color.withOpacity(0.15),
                        ),
                      ),
                    ],
                    layers: [
                      MarkerLayerOptions(markers: [
                        Marker(
                          point: LatLng(
                              c.tripLatitude.value, c.tripLongitude.value),
                          width: iconSize,
                          height: iconSize,
                          builder: (context) => Zone(size: iconSize),
                        )
                      ]),
                      /* CircleLayerOptions(circles: [
                        CircleMarker(
                          point:
                              LatLng(c.tripLatitude.value, c.tripLongitude.value),
                          color: Colors.green.withOpacity(0.8),
                          useRadiusInMeter: true,
                          radius: 1000,
                        ),
                      ]), */
                    ],
                  ),
                  GetInZone(),
                ],
              )
            : Center(
                child: CircularProgressIndicator.adaptive(),
              ),
        bottomNavigationBar: PixtripMapBottomBar(),
      ),
    );
  }
}

class GetInZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25.0,
      child: Material(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: EdgeInsets.all(15.0),
          width: Get.width * 0.9,
          decoration: BoxDecoration(),
          child: Text(
            'travel__get_in_zone'.tr,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
