import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/components/wallet/coupon.dart';
import 'package:pixtrip/components/wallet/empty_list.dart';
import 'package:pixtrip/components/wallet/separator.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class UnusedCoupons extends StatelessWidget {
  final List<dynamic> unusedCoupons;

  const UnusedCoupons({Key key, this.unusedCoupons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return unusedCoupons.length > 0
        ? ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: unusedCoupons.length,
            itemBuilder: (context, index) {
              final item = unusedCoupons[index];
              return Coupon(
                i: item['id'],
                title: item['name'],
                data: item['code'],
                image: item['image'],
                infosId: item['infos_id'],
              );
            },
            separatorBuilder: (context, index) => Separator(),
          )
        : EmptyList('wallet__empty_unused_coupons'.tr);
  }
}
