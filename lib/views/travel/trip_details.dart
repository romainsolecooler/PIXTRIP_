import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/custom_colors.dart';
import 'package:pixtrip/common/social_buttons.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/parcour.dart';

import 'package:expandable_page_view/expandable_page_view.dart';

Controller c = Get.find();

class TripDetails extends StatefulWidget {
  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  void initState() {
    super.initState();
    //c.setFinishedTrip(false);
    if (c.finishedTrip.value) {
      postPositions();
      getTripCoupons();
    } else {
      getPositions();
    }
  }

  void postPositions() async {
    await dio.post(
      'trip/add_completed_trip.php',
      data: {
        'user_id': c.userId.value,
        'trip_id': c.tripId.value,
        'coordinates': c.positionList,
      },
    );
    logger.i('posted positions');
  }

  void getPositions() async {
    logger.d('getting position list');
    var response = await dio.post('trip/get_trip_positions.php', data: {
      'user_id': c.userId.value,
      'trip_id': c.tripId.value,
    });
    c.setPositionList(response.data);
    logger.i('got positions');
  }

  void getTripCoupons() async {
    var response = await dio.post('trip/get_trip_coupons.php', data: {
      'trip_id': c.tripId.value,
    });
    c.setCouponList(response.data);
  }

  @override
  void dispose() {
    print('dispose');
    c.setChosenCoupon('', '');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Image(),
                SizedBox(height: 20.0),
                _Name(),
                SizedBox(height: 20.0),
                _Actions(),
              ],
            ),
          ),
        )
      ],
    );

    return c.finishedTrip.value
        ? child
        : Scaffold(
            appBar: appBar,
            body: child,
          );
  }
}

class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: LoadImageWithLoader(
            url: 'trips/${c.tripImage.value}',
          ),
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.45,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Text(
          c.tripCity.value,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Actions extends StatefulWidget {
  @override
  __ActionsState createState() => __ActionsState();
}

class __ActionsState extends State<_Actions> {
  bool _showAnecdotes = true;
  bool _faved = false;
  bool _loadingFaved = false;

  void toggleFaved() async {
    setState(() => _loadingFaved = true);
    var response = await dio.post('trip/toggle_fav.php', data: {
      'user_id': c.userId.value,
      'trip_id': c.tripId.value,
    });
    var data = response.data;
    setState(() {
      _loadingFaved = false;
      _faved = data['faved'];
    });
  }

  void share() {
    int positionListLength = c.positionList.length;
    double traveledDistance = 0;
    for (int i = 0; i < positionListLength - 1; i++) {
      final item = c.positionList[i];
      final nextItem = c.positionList[i + 1];
      traveledDistance += Geolocator.distanceBetween(
        item['lat'],
        item['lon'],
        nextItem['lat'],
        nextItem['lon'],
      );
    }
    int steps = (traveledDistance / 0.762).floor();
    String displayDistance = traveledDistance < 1000
        ? 'measure__meters'.trParams({
            'distance': traveledDistance.round().toString(),
          })
        : 'measure__kilometers'.trParams({
            'distance': (traveledDistance / 1000).toStringAsFixed(3).toString(),
          });
    Map<String, String> tripData = {
      'distance': displayDistance,
      'steps': steps.toString(),
      'name': c.tripCity.value,
    };
    String message = 'trip_details__share_message'.trParams(tripData);
    final RenderBox box = context.findRenderObject();
    Share.share(
      message,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  void showShareOptions() {
    Get.bottomSheet(
      ShareOptions(),
    );
  }

  @override
  void initState() {
    isFaved();
    super.initState();
  }

  void isFaved() async {
    setState(() => _loadingFaved = true);
    var response = await dio.post('trip/is_faved.php', data: {
      'user_id': c.userId.value,
      'trip_id': c.tripId.value,
    });
    setState(() {
      _loadingFaved = false;
      _faved = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget info = _showAnecdotes ? _Anecdotes() : _Infos();
    IconData favedIcon = _faved ? Icons.favorite : Icons.favorite_border;

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _loadingFaved
                  ? CircularProgressIndicator.adaptive()
                  : IconButton(
                      icon: Icon(favedIcon),
                      onPressed: () => toggleFaved(),
                    ),
              IconButton(
                icon: Icon(Icons.assignment),
                onPressed: () =>
                    setState(() => _showAnecdotes = !_showAnecdotes),
              ),
              Obx(() {
                if (c.positionList.length > 0) {
                  return IconButton(
                    icon: Icon(Icons.share),
                    onPressed: share,
                  );
                }
                return CircularProgressIndicator.adaptive();
              }),
            ],
          ),
          SizedBox(height: 15.0),
          info,
        ],
      ),
    );
  }
}

class ShareOptions extends StatelessWidget {
  //final FlutterShareMe share = FlutterShareMe();

  ShareOptions({Key key}) : super(key: key);

  Map<String, String> getTripData() {
    int positionListLength = c.positionList.length;
    double traveledDistance = 0;
    for (int i = 0; i < positionListLength - 1; i++) {
      final item = c.positionList[i];
      final nextItem = c.positionList[i + 1];
      traveledDistance += Geolocator.distanceBetween(
        item['lat'],
        item['lon'],
        nextItem['lat'],
        nextItem['lon'],
      );
    }
    int steps = (traveledDistance / 0.762).floor();
    String displayDistance = traveledDistance < 1000
        ? '${traveledDistance.round()} m'
        : '${(traveledDistance / 1000).toStringAsFixed(3)} km';
    return {
      'distance': displayDistance,
      'steps': steps.toString(),
      'name': c.tripCity.value,
    };
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> tripData = getTripData();
    String message = 'trip_details__share_message'.trParams(tripData);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('trip_details__share_title'.tr),
          SizedBox(height: 25.0),
          Row(
            children: [
              SocialButton(
                name: 'facebook',
                function: () => print(
                    'toto'), /* share.shareToFacebook(
                  msg: message,
                  url: 'https://www.facebook.com/PixtripApp',
                ), */
              ),
              SizedBox(width: 25.0),
              SocialButton(
                name: 'twitter',
                function: () => print('twitter'),
              ),
              SizedBox(width: 25.0),
              SocialButton(
                name: 'whatsapp',
                function: () => print('whatsapp'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Anecdotes extends StatefulWidget {
  @override
  __AnecdotesState createState() => __AnecdotesState();
}

class __AnecdotesState extends State<_Anecdotes> {
  final CarouselController _controller = CarouselController();
  bool _showCoupons = false;

  void showCouponList(bool newValue) {
    setState(() => _showCoupons = newValue);
  }

  @override
  Widget build(BuildContext context) {
    return _showCoupons
        ? _CouponList(
            showCouponList: showCouponList,
          )
        : Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => _controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => CarouselSlider(
                        items: [
                          _Anecdote(anecdote: c.tripAnecdote_1.value),
                          _Anecdote(anecdote: c.tripAnecdote_2.value),
                          if (c.tripAnecdote_3.value != '')
                            _Anecdote(anecdote: c.tripAnecdote_3.value),
                        ],
                        carouselController: _controller,
                        options: CarouselOptions(
                          initialPage: c.anecdoteIndex.value,
                          viewportFraction: 1.0,
                          onPageChanged: (index, _) =>
                              c.setAnecdoteIndex(index),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () => _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ],
              ),
              !c.finishedTrip.value ? Container() : Divider(),
              SizedBox(height: 25.0),
              !c.finishedTrip.value
                  ? Container()
                  : Material(
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Obx(
                          () {
                            String image;
                            String name;
                            Widget button;
                            if (c.chosenCouponName.value != '') {
                              image = c.chosenCouponImage.value;
                              name = c.chosenCouponName.value;
                              button = Container();
                            } else {
                              image = null;
                              name = 'trip_details__choose_coupon'.tr;
                              button = Container(
                                decoration: BoxDecoration(
                                  color: redColor[900],
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () => showCouponList(true),
                                  color: Colors.white,
                                ),
                              );
                            }
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: _CouponImage(image: image),
                                ),
                                Text(name),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: button,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
            ],
          );
  }
}

class _Anecdote extends StatelessWidget {
  final String anecdote;

  const _Anecdote({Key key, this.anecdote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, size) {
          var span = TextSpan(text: anecdote);
          var tp = TextPainter(
            maxLines: 5,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            text: span,
          );
          tp.layout(maxWidth: size.maxWidth);
          var exceeded = tp.didExceedMaxLines;
          return GestureDetector(
            onTap: () => exceeded
                ? Get.dialog(
                    _ExpandedAnecdotes(),
                    barrierColor: Colors.transparent,
                  )
                : null,
            child: Text(
              anecdote,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
          );
        },
      ),
    );
  }
}

class _ExpandedAnecdotes extends StatelessWidget {
  final CarouselController _controller = CarouselController();
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () => pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                Expanded(
                  child: ExpandablePageView(
                    controller: pageController,
                    children: [
                      _ExpandedAnecdote(anecdote: c.tripAnecdote_1.value),
                      _ExpandedAnecdote(anecdote: c.tripAnecdote_2.value),
                      if (c.tripAnecdote_3.value != '')
                        _ExpandedAnecdote(anecdote: c.tripAnecdote_3.value)
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right),
                  onPressed: () => pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpandedAnecdote extends StatelessWidget {
  final String anecdote;

  const _ExpandedAnecdote({Key key, this.anecdote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(anecdote),
      ),
    );
  }
}

class _Infos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(20.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          int positionListLength = c.positionList.length;
          if (positionListLength > 0) {
            double traveledDistance = 0;
            for (int i = 0; i < positionListLength - 1; i++) {
              final item = c.positionList[i];
              final nextItem = c.positionList[i + 1];
              traveledDistance += Geolocator.distanceBetween(
                item['lat'],
                item['lon'],
                nextItem['lat'],
                nextItem['lon'],
              );
            }
            int steps = (traveledDistance / 0.762).floor();
            String displayDistance = traveledDistance < 1000
                ? '${traveledDistance.round()} m'
                : '${(traveledDistance / 1000).toStringAsFixed(3)} km';
            if (traveledDistance > 999) {
              traveledDistance = traveledDistance.roundToDouble();
            }
            return Column(
              children: [
                Text('trip_details__steps'.tr),
                _InfosText(text: '$steps'),
                _InfosDivider(),
                Text('trip_details__traveled_distance'.tr),
                _InfosText(text: '$displayDistance'),
                _InfosDivider(),
                Text('trip_details__travel_realised'.tr),
                SizedBox(height: 10.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 6,
                    child: Parcour(little: true),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator.adaptive();
        }),
      ),
    );
  }
}

class _InfosText extends StatelessWidget {
  final String text;

  const _InfosText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5.copyWith(
            height: 1.4,
          ),
    );
  }
}

class _InfosDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double indent = Get.width * 0.15;
    return Divider(
      indent: indent,
      endIndent: indent,
      height: 25.0,
    );
  }
}

class _CouponList extends StatelessWidget {
  final Function showCouponList;

  const _CouponList({
    Key key,
    @required this.showCouponList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Obx(() {
            if (c.couponList.length > 0) {
              return Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: c.couponList.length,
                    itemBuilder: (context, index) {
                      final item = c.couponList[index];
                      return _Coupon(
                        coupon: item,
                        showCouponList: showCouponList,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(indent: 25, endIndent: 25);
                    },
                  ),
                  ClipOval(
                    child: Container(
                      color: redColor[900],
                      child: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => showCouponList(false),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
            return CircularProgressIndicator.adaptive();
          }),
        ),
      ),
    );
  }
}

class _Coupon extends StatelessWidget {
  final Map<String, dynamic> coupon;
  final Function showCouponList;

  const _Coupon({Key key, this.coupon, this.showCouponList}) : super(key: key);

  void addToWallet() async {
    var response = await dio.post('coupon/add_to_wallet.php', data: {
      'user_id': c.userId.value,
      'coupon_id': coupon['id'],
    });
    var data = response.data;
    Get.back();
    String title;
    String text;
    if (data['error']) {
      title = 'error_title';
      text = 'trip_details__added_coupon_error';
    } else {
      title = 'sucess_title';
      text = 'trip_details__added_coupon_text';
      c.setChosenCoupon(coupon['image'], coupon['name']);
      showCouponList(false);
    }
    Get.defaultDialog(
      title: title.tr,
      content: Text(
        text.tr,
        textAlign: TextAlign.center,
      ),
      textConfirm: 'ok'.tr,
      confirmTextColor: Colors.white,
      buttonColor: redColor[900],
      onConfirm: () => Get.back(),
    );
    logger.wtf(response.data);
  }

  void selectCoupon() {
    Get.defaultDialog(
      title: 'trip_details__select_coupon_title'.tr,
      content: Text(
        'trip_details__select_coupon_text'.tr,
        textAlign: TextAlign.center,
      ),
      textConfirm: 'trip_details__select_confirm'.tr,
      textCancel: 'trip_details__select_cancel'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: redColor[900],
      buttonColor: redColor[900],
      onConfirm: () => addToWallet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCoupon(),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: _CouponImage(image: coupon['image']),
            ),
            Text(coupon['name']),
          ],
        ),
      ),
    );
  }
}

class _CouponImage extends StatelessWidget {
  final String image;
  final double _imageSize = 50.0;

  const _CouponImage({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: SizedBox(
        width: _imageSize,
        height: _imageSize,
        child: image == null
            ? Image.asset('assets/images/tutorial/5.png')
            : LoadImageWithLoader(
                url: 'coupons/$image',
              ),
      ),
    );
  }
}
