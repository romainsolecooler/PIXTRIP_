import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/components/trips/sliders/sliders.dart';

import 'package:pixtrip/controllers/controller.dart';

Controller c = Get.find();

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
  final Duration _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    ever(c.settingsCurrentPosition, (_) => print("$_ has been changed"));

    return InkWell(
      onTap: () =>
          c.setSettingsCurrentPosition(!c.settingsCurrentPosition.value),
      borderRadius: BorderRadius.circular(50.0),
      splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
      child: Obx(
        () => AnimatedContainer(
          duration: _duration,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(50.0),
            color: c.settingsCurrentPosition.value
                ? Theme.of(context).colorScheme.secondary
                : Colors.black.withOpacity(0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.my_location,
                  color: c.settingsCurrentPosition.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: _duration,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: c.settingsCurrentPosition.value
                          ? Colors.white
                          : Colors.black,
                    ),
                child: Text('trips__current_position'.tr),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ValidateSettings extends StatefulWidget {
  @override
  __ValidateSettingsState createState() => __ValidateSettingsState();
}

class __ValidateSettingsState extends State<_ValidateSettings> {
  bool _loading = false;

  void updateSettings() {
    c.checkHttpResponse(
        url: 'trip/get_all_trips.php',
        data: {
          'distance': c.sliderDistance.value,
          'difficulty': c.sliderDifficulty.value,
          'time': c.sliderTime.value,
        },
        loading: () => setState(() => _loading = true),
        error: () => setState(() => _loading = false),
        callBack: (data) {
          c.setTripsList(data);
          Get.back();
          setState(() => _loading = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : Container(
            margin: EdgeInsets.only(top: 25.0),
            child: ElevatedButton(
              onPressed: () => updateSettings(),
              child: Text('trips__validate'.tr),
            ),
          );
  }
}
