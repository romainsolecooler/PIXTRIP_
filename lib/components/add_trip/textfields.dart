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
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'add_trip__add_city_placeholder'.tr,
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
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'add_trip__add_first_info_placeholder'.tr,
      ),
      onChanged: (text) => c.setAddFirstInfo(text),
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
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
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'add_trip__add_second_info_placeholder'.tr,
      ),
      onChanged: (text) => c.setAddSecondInfo(text),
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
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
    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'add_trip__add_third_info_placeholder'.tr,
      ),
      onChanged: (text) => c.setAddThirdInfo(text),
      controller: _controller,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    );
  }
}
