import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_transition_button/loading_transition_button.dart';
import 'package:pixtrip/common/custom_colors.dart';

class AnimatedButton extends StatefulWidget {
  final Function callBack;

  AnimatedButton({
    Key key,
    @required this.callBack,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  LoadingButtonController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoadingButtonController();
  }

  void submit() {
    widget.callBack();
    print('tototo');
    _controller.stopLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width * 0.45;
    return Container(
      width: width,
      height: 50,
      child: LoadingButton(
        color: redColor[900],
        controller: _controller,
        child: Text(
          'login__continue'.tr,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onSubmit: () => submit(),
      ),
    );
  }
}
