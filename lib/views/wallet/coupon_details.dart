import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/components/wallet/info_position.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/wallet/coupon.dart';

class CouponDetails extends StatelessWidget {
  final Coupon coupon;

  const CouponDetails({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _size = MediaQuery.of(context).size.width * 0.75;

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            coupon,
            _PageDivider(),
            InfoPosition(),
            SizedBox(height: 50.0),
            QrImage(
              data: coupon.data,
              size: _size,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageDivider extends StatelessWidget {
  final double _indent = 50.0;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: _indent,
      endIndent: _indent,
      height: 75.0,
    );
  }
}
