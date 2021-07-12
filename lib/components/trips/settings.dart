import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixtrip/components/trips/category_choice.dart';
import 'package:pixtrip/components/trips/environment.dart';
import 'package:pixtrip/components/trips/sliders/sliders.dart';

import 'package:pixtrip/controllers/controller.dart';
import 'package:pixtrip/controllers/settings_controller.dart';
import 'package:pixtrip/controllers/trip_list_controller.dart';

import 'sliders/sliders.dart';

Controller c = Get.find();
TripListController tripListController = Get.find();

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
          height: Get.height * 0.6,
          constraints: BoxConstraints(maxHeight: Get.height * 0.8),
          child: ListView(
            children: [
              _SettingsTextField(),
              _SettingsDivider(),
              _CurrentPositionButton(),
              SizedBox(height: 25.0),
              Environment(),
              SizedBox(height: 10.0),
              DistanceSlider(),
              SizedBox(height: 15.0),
              DifficultyPicker(),
              SizedBox(height: 20.0),
              CategoryChoice(),
              _ValidateSettings(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTextField extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 13.0),
        hintText: 'trips__city_name'.tr,
      ),
      style: Theme.of(context).textTheme.bodyText1,
      onChanged: (text) => controller.cityName(text),
      initialValue: controller.cityName(),
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

class _CurrentPositionButton extends GetView<SettingsController> {
  final Duration _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.currentPosition.toggle,
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
            color: controller.currentPosition()
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
                  color: controller.currentPosition()
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: _duration,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: controller.currentPosition()
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
    tripListController.orderTrips();
    Get.back();
    /* c.checkHttpResponse(
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
        }); */
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : Center(
            child: Container(
              margin: EdgeInsets.only(top: 25.0),
              child: ElevatedButton(
                onPressed: () => updateSettings(),
                child: Text('trips__validate'.tr),
              ),
            ),
          );
  }
}
