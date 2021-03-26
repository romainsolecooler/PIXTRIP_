import 'package:flutter/material.dart';
import 'package:pixtrip/components/wallet/coupon.dart';
import 'package:pixtrip/components/wallet/separator.dart';

class UnusedCoupons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = List<String>.generate(12, (index) => 'Coupon $index');

    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Coupon(
          i: index,
          title: 'Coupon numéro $index',
          data: 'data__${index}__',
        );
      },
      separatorBuilder: (context, index) => Separator(),
    );
  }
}
