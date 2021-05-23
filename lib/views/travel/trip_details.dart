import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pixtrip/common/app_bar.dart';
import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/views/travel/parcour.dart';

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
    } else {
      getPositions();
    }
    getTripCoupons();
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
  Widget build(BuildContext context) {
    Widget child = Padding(
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
  @override
  Widget build(BuildContext context) {
    Widget info = _showAnecdotes ? _Anecdotes() : _Infos();

    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () => print('add to fav'),
              ),
              IconButton(
                icon: Icon(Icons.assignment),
                onPressed: () =>
                    setState(() => _showAnecdotes = !_showAnecdotes),
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () => print('share'),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          info,
        ],
      ),
    );
  }
}

class _Anecdotes extends StatelessWidget {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Row(
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
                _Anecdote(anecdote: c.tripAnecdote_3.value),
                if (c.tripAnecdote_3.value != '')
                  _Anecdote(anecdote: c.tripAnecdote_3.value),
              ],
              carouselController: _controller,
              options: CarouselOptions(
                initialPage: c.anecdoteIndex.value,
                viewportFraction: 1.0,
                onPageChanged: (index, _) => c.setAnecdoteIndex(index),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
        child: Material(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                onPressed: () => _controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    initialPage: c.anecdoteIndex.value,
                    viewportFraction: 1.0,
                    height: 300,
                    onPageChanged: (index, _) => c.setAnecdoteIndex(index),
                  ),
                  items: [
                    _ExpandedAnecdote(anecdote: c.tripAnecdote_1.value),
                    _ExpandedAnecdote(anecdote: c.tripAnecdote_2.value),
                    if (c.tripAnecdote_3.value != '')
                      _ExpandedAnecdote(anecdote: c.tripAnecdote_3.value),
                  ],
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(anecdote),
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
              print(item['lat'].runtimeType);
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
