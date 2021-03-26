import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPosition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.6;

    return InkWell(
      onTap: () => print('info et position'),
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        width: _width,
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.pin_drop,
              ),
            ),
            Text('coupon_details__info_position'.tr),
          ],
        ),
      ),
    );
  }
}
