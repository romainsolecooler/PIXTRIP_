import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/components/trips/sliders/sliders.dart';

import 'package:pixtrip/controllers/controller.dart';

class TripsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.9;

    return Center(
      child: Material(
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
          width: _width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SettingsTextField(),
              _SettingsDivider(),
              _CurrentPositionButton(),
              DistanceSlider(),
              TimeSlider(),
              DifficultySlider(),
              _ValidateSettings(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTextField extends StatefulWidget {
  @override
  __SettingsTextFieldState createState() => __SettingsTextFieldState();
}

class __SettingsTextFieldState extends State<_SettingsTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Controller c = Get.find();
    _controller.text = c.settingsCityName.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).dividerColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    );

    return TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
        hintText: 'trips__city_name'.tr,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: (text) => c.setSettingsCityName(text),
      controller: _controller,
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('trips__or'.tr),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _CurrentPositionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        icon: Icon(
          Icons.my_location,
          color: Colors.black,
        ),
        label: Text(
          'trips__current_position'.tr,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: () => print('current position taped narvalo'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(color: Colors.grey),
          )),
        ),
      ),
    );
  }
}

class _ValidateSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('trips__validate'.tr),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
        ),
      ),
    );
  }
}
