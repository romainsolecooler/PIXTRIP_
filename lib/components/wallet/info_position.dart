import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:pixtrip/common/utils.dart';
import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

class InfoPosition extends StatefulWidget {
  @override
  _InfoPositionState createState() => _InfoPositionState();
}

class _InfoPositionState extends State<InfoPosition> {
  bool _loading = false;
  bool _show = true;
  Map<String, dynamic> _infos;

  @override
  void initState() {
    getMerchantInfos();
    super.initState();
  }

  void getMerchantInfos() async {
    setState(() => _loading = true);
    var response = await dio.post(
      'coupon/get_merchant_infos.php',
      data: {'id': c.infosId.value},
    );
    var data = response.data;
    int dataLength = 0;
    int nullLength = 0;
    data.forEach((key, value) {
      dataLength++;
      if (value == null) {
        nullLength++;
      }
    });
    bool show = dataLength > nullLength;
    setState(() {
      _loading = false;
      _infos = data;
      _show = show;
    });
  }

  void showInfos() {
    Get.dialog(_Infos(infos: _infos));
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.6;

    return _loading
        ? CircularProgressIndicator.adaptive()
        : _show
            ? InkWell(
                onTap: () => showInfos(),
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  width: _width,
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.pin_drop,
                        ),
                      ),
                      Text('coupon_details__info_position'.tr),
                    ],
                  ),
                ),
              )
            : Container();
  }
}

class _Infos extends StatelessWidget {
  final Map<String, dynamic> infos;

  const _Infos({Key key, this.infos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Container(
          width: Get.width * 0.9,
          constraints: BoxConstraints(maxHeight: Get.height * 0.7),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InfoString(
                  label: 'merchant_infos__name',
                  info: infos['name'],
                ),
                _InfoString(
                  label: 'merchant_infos__address',
                  info: infos['address'],
                  canCopy: true,
                ),
                _InfoString(
                  label: 'merchant_infos__phone',
                  info: infos['phone'],
                  canCopy: true,
                ),
                _OpenAt(openAt: jsonDecode(infos['open_at'])),
                _InfoString(
                  label: 'merchant_infos__link',
                  info: infos['link'],
                  canCopy: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoString extends StatelessWidget {
  final String label;
  final String info;
  final bool canCopy;

  const _InfoString({
    Key key,
    this.info,
    this.label,
    this.canCopy = false,
  }) : super(key: key);

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: info)).then((_) {
      Get.snackbar(
        'sucess_title'.tr,
        'copied_to_clipboard'.tr,
        margin: EdgeInsets.only(bottom: 25.0),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget infoText = Text(info);
    Widget child = canCopy
        ? GestureDetector(
            child: infoText,
            onTap: copyToClipboard,
          )
        : infoText;

    return Container(
      child: info == null
          ? null
          : Column(
              children: [
                _Label(label: label),
                SizedBox(height: 5.0),
                child,
                SizedBox(height: 25.0),
              ],
            ),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;

  const _Label({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label.tr,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

class _OpenAt extends StatelessWidget {
  final Map<String, dynamic> openAt;

  const _OpenAt({Key key, this.openAt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _Label(label: 'merchant_infos__open_at'),
    ];

    openAt.forEach((key, value) {
      children.add(_OpenDay(day: key, hours: value));
    });
    return Container(
      child: Column(
        children: children,
      ),
    );
  }
}

class _OpenDay extends StatelessWidget {
  final String day;
  final List hours;

  const _OpenDay({Key key, this.day, this.hours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(day.tr),
          _Hours(hours: hours),
        ],
      ),
    );
  }
}

class _Hours extends StatelessWidget {
  final List<dynamic> hours;
  final double height = 30.0;

  const _Hours({Key key, this.hours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d(hours.length);
    return hours.length > 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: hours.length,
                    itemBuilder: (context, index) => Text(hours[index]),
                    separatorBuilder: (context, _) => SizedBox(width: 15.0),
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: height,
            child: Text('closed'.tr),
          );
  }
}
