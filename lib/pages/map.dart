import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pixtrip/common/app_bar.dart';

class PixtripMap extends StatefulWidget {
  @override
  _PixtripMapState createState() => _PixtripMapState();
}

class _PixtripMapState extends State<PixtripMap> {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: OSMFlutter(
        controller: _mapController,
      ),
    );
  }
}
