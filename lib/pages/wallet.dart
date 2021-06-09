import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/components/wallet/unused_coupons.dart';
import 'package:pixtrip/components/wallet/used_coupons.dart';

Controller c = Get.find();

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    print('inited state');
    if (!c.usedCouponsLoaded.value && !c.unusedCouponsLoaded.value) {
      c.checkHttpResponse(
          url: 'coupon/get_user_coupons.php',
          data: {
            'user_id': c.userId.value,
          },
          loading: () => null,
          error: () => null,
          callBack: (data) {
            print(data);
            List<dynamic> usedCoupons = [];
            List<dynamic> unusedCoupons = [];
            for (final item in data) {
              if (item['used'] == 0) {
                unusedCoupons.add(item);
              } else {
                usedCoupons.add(item);
              }
            }
            c.setUnusedCoupons(unusedCoupons);
            c.setUsedCoupons(usedCoupons);
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (c.usedCouponsLoaded.value && c.unusedCouponsLoaded.value) {
          if (c.unusedCoupons.length == 0 && c.usedCoupons.length == 0) {
            return EmptyWallet();
          }
          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10.0),
                UnusedCoupons(unusedCoupons: c.unusedCoupons),
                _PageSeparator(),
                UsedCoupons(usedCoupons: c.usedCoupons),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator.adaptive());
        }
      },
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

class EmptyWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('wallet__empty'.tr),
    );
  }
}
