import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPosition extends StatefulWidget {
  @override
  _AddPositionState createState() => _AddPositionState();
}

class _AddPositionState extends State<AddPosition> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.5;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      width: _width,
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: () => print('get position'),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.pin_drop),
              ),
              Text(
                'add_trip__add_position_placeholder'.tr,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
