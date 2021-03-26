import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/wallet/unused_coupons.dart';
import 'package:pixtrip/components/wallet/used_coupons.dart';

class Wallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            UnusedCoupons(),
            _PageSeparator(),
            UsedCoupons(),
          ],
        ),
      ),
    );
  }
}

class _PageSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.4;

    return Opacity(
      opacity: 0.5,
      child: Container(
        width: _width,
        padding: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
            ),
          ),
        ),
        child: Center(
          child: Text('wallet__page_separator'.tr),
        ),
      ),
    );
  }
}
