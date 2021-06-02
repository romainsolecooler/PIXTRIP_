import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get.dart';
import 'package:latlong/latlong.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class Parcour extends StatelessWidget {
  final bool little;

  const Parcour({Key key, this.little = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LatLng> points = [];

    for (final item in c.positionList) {
      points.add(LatLng(item['lat'], item['lon']));
    }

    Widget child = FlutterMap(
      options: MapOptions(
        center: LatLng(c.tripLatitude.value, c.tripLongitude.value),
        zoom: little ? 13.6 : 15.0,
        maxZoom: 18.4,
        onTap: (_) => little ? Get.to(() => Parcour()) : null,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayerOptions(polylines: [
          Polyline(
            points: points,
            strokeWidth: 5.0,
            color: Theme.of(context).primaryColor,
          )
        ]),
      ],
    );

    return little
        ? child
        : Scaffold(
            appBar: appBar,
            body: child,
          );
  }
}
