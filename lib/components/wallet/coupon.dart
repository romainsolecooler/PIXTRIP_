import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/utils.dart';

import 'package:pixtrip/controllers/controller.dart';

import 'package:pixtrip/components/wallet/used_coupons.dart';
import 'package:pixtrip/views/wallet/coupon_details.dart';

Controller c = Get.find();

class Coupon extends StatelessWidget {
  final bool used;
  final bool opened;
  final int i;
  final String title;
  final String data;
  final String image;
  final int infosId;

  const Coupon({
    Key key,
    this.used = false,
    this.opened = false,
    this.i,
    this.title,
    this.data = '',
    this.image,
    this.infosId,
  }) : super(key: key);

  void openCouponDetails(BuildContext context) {
    c.setInfosId(infosId);
    Get.to(() => CouponDetails(
          coupon: Coupon(
            i: i,
            title: title,
            opened: true,
            data: data,
            image: image,
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
                    child: CouponImage(image: image),
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

class CouponImage extends StatelessWidget {
  final String image;
  final double _imageSize = 50.0;

  const CouponImage({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: SizedBox(
        width: _imageSize,
        height: _imageSize,
        child: LoadImageWithLoader(
          url: 'coupons/$image',
        ),
      ),
    );
  }
}
