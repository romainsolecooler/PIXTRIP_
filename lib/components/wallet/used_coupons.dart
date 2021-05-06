import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/components/wallet/coupon.dart';
import 'package:pixtrip/components/wallet/empty_list.dart';
import 'package:pixtrip/components/wallet/separator.dart';

class UsedCoupons extends StatelessWidget {
  final List<dynamic> usedCoupons;

  const UsedCoupons({Key key, this.usedCoupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return usedCoupons.length > 0
        ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: usedCoupons.length,
            itemBuilder: (context, index) {
              final item = usedCoupons[index];
              return Coupon(
                i: item['id'],
                title: item['name'],
                image: item['image'],
                used: true,
              );
            },
            separatorBuilder: (context, index) => Separator(),
          )
        : EmptyList('wallet__empty_used_coupons'.tr);
  }
}
