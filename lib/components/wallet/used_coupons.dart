import 'package:flutter/material.dart';
import 'package:pixtrip/components/wallet/coupon.dart';

import 'package:pixtrip/components/wallet/separator.dart';

class UsedCoupons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(17, (index) => 'Coupon utilisé $index');

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Coupon(
          i: index,
          title: 'Coupon numéro $index',
          used: true,
        );
      },
      separatorBuilder: (context, index) => Separator(),
    );
  }
}
