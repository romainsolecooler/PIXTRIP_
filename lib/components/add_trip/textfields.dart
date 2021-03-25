import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pixtrip/controllers/controller.dart';

class CityName extends StatefulWidget {
  @override
  _CityNameState createState() => _CityNameState();
}

class _CityNameState extends State<CityName> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Controller c = Get.find();
    _controller.text = c.addCityName.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
      placeholder: 'add_trip__add_city_placeholder'.tr,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      onChanged: (text) => c.setAddCityName(text),
      controller: _controller,
    );
  }
}

class FirstInfo extends StatefulWidget {
  @override
  _FirstInfoState createState() => _FirstInfoState();
}

class _FirstInfoState extends State<FirstInfo> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Controller c = Get.find();
    _controller.text = c.addFirstInfo.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
      placeholder: 'add_trip__add_first_info_placeholder'.tr,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      onChanged: (text) => c.setAddFirstInfo(text),
      controller: _controller,
    );
  }
}

class SecondInfo extends StatefulWidget {
  @override
  _SecondInfoState createState() => _SecondInfoState();
}

class _SecondInfoState extends State<SecondInfo> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Controller c = Get.find();
    _controller.text = c.addSecondInfo.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
      placeholder: 'add_trip__add_second_info_placeholder'.tr,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      onChanged: (text) => c.setAddSecondInfo(text),
      controller: _controller,
    );
  }
}

class ThirdInfo extends StatefulWidget {
  @override
  _ThirdInfoState createState() => _ThirdInfoState();
}

class _ThirdInfoState extends State<ThirdInfo> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Controller c = Get.find();
    _controller.text = c.addThirdInfo.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
      placeholder: 'add_trip__add_third_info_placeholder'.tr,
      textAlign: TextAlign.center,
      cursorColor: Theme.of(context).primaryColor,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      onChanged: (text) => c.setAddThirdInfo(text),
      controller: _controller,
    );
  }
}
