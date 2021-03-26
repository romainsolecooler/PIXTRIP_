import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:pixtrip/controllers/controller.dart';

import 'package:pixtrip/components/wallet/used_coupons.dart';
import 'package:pixtrip/views/wallet/coupon_details.dart';

class Coupon extends StatelessWidget {
  final bool used;
  final bool opened;
  final int i;
  final String title;
  final String data;

  const Coupon({
    Key key,
    this.used = false,
    this.opened = false,
    this.i,
    this.title,
    this.data = '',
  }) : super(key: key);

  void openCouponDetails(BuildContext context) {
    pushNewScreen(context,
        screen: CouponDetails(
          coupon: Coupon(
            i: i,
            title: title,
            opened: true,
            data: data,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: opened,
      child: InkWell(
        onTap: used ? null : () => openCouponDetails(context),
        child: Material(
          elevation: opened ? 16.0 : 0.0,
          child: Opacity(
            opacity: used ? 0.5 : 1.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Square(i: i),
                  ),
                  Text(title),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  final int i;

  const Square({Key key, this.i}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text('$i'),
      ),
    );
  }
}
