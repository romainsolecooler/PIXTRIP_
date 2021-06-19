import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pixtrip/common/utils.dart';

import 'package:pixtrip/controllers/controller.dart';

class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    Controller c = Get.find();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Material(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          color: Colors.white,
          child: CarouselSlider(
            carouselController: c.carouselController.value,
            options: CarouselOptions(
              height: _screenSize.height * 0.7,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
            ),
            items: [Tuto1(), Tuto2(), Tuto3(), Tuto4(), Tuto5(), Tuto6()],
          ),
        ),
      ),
    );
  }
}

class CanGoBackTitle extends StatelessWidget {
  final String text;

  const CanGoBackTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controller c = Get.find();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 35,
              ),
              onPressed: () => c.carouselController.value.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            ),
          ),
          TutorialTitle(text: text),
        ],
      ),
    );
  }
}

class NextButton extends StatelessWidget {
  final bool last;

  const NextButton({Key key, this.last = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String buttonText = last ? 'tutorial__next_last'.tr : 'tutorial__next'.tr;

    Controller c = Get.find();

    void closeTutorial() async {
      Get.back();
      c.setTutorialStep(1);
      await dio.post('user/set_tutorial.php', data: {
        'u_id': c.userId.value,
      });
    }

    return ElevatedButton(
      onPressed: () => last
          ? closeTutorial()
          : c.carouselController.value.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
      child: Text(buttonText),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ))),
    );
  }
}

class TutorialTitle extends StatelessWidget {
  final String text;

  const TutorialTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class TutorialText extends StatelessWidget {
  final String text;

  const TutorialText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
    );
  }
}

class TutorialContent extends StatelessWidget {
  final String titleText;
  final String imagePath;
  final String tutorialText;
  final bool last;

  const TutorialContent({
    Key key,
    this.titleText,
    this.imagePath,
    this.tutorialText,
    this.last = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CanGoBackTitle(text: titleText),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: Column(
              children: [
                Divider(),
                SizedBox(height: 20.0),
                Expanded(
                  child: Image.asset(
                    imagePath,
                  ),
                ),
                Divider(height: 80.0),
                TutorialText(text: tutorialText),
                SizedBox(height: 40.0),
                NextButton(last: last),
                SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TutorialContentWithoutImage extends StatelessWidget {
  final String titleText;
  final String text;
  final String subText;

  const TutorialContentWithoutImage(
      {Key key, this.titleText, this.text, this.subText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CanGoBackTitle(text: ''),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TutorialTitle(text: titleText),
                Divider(height: 100),
                TutorialText(text: text),
                TutorialText(text: subText),
                NextButton(last: true),
                SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Tuto1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__1_title'.tr,
      imagePath: 'assets/images/tutorial/1.png',
      tutorialText: 'tutorial__1_text'.tr,
    );
  }
}

class _Tuto1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TutorialTitle(text: 'tutorial__1_title'.tr),
          Divider(),
          TutorialText(text: 'tutorial__1_text'.tr),
          NextButton(),
        ],
      ),
    );
  }
}

class Tuto2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__2_title'.tr,
      imagePath: 'assets/images/tutorial/2.png',
      tutorialText: 'tutorial__2_text'.tr,
    );
  }
}

class Tuto3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__3_title'.tr,
      imagePath: 'assets/images/tutorial/3.png',
      tutorialText: 'tutorial__3_text'.tr,
    );
  }
}

class Tuto4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__4_title'.tr,
      imagePath: 'assets/images/tutorial/4.png',
      tutorialText: 'tutorial__4_text'.tr,
    );
  }
}

class Tuto5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__5_title'.tr,
      imagePath: 'assets/images/tutorial/5.png',
      tutorialText: 'tutorial__5_text'.tr,
    );
  }
}

class Tuto6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContent(
      titleText: 'tutorial__6_title'.tr,
      imagePath: 'assets/images/tutorial/6.png',
      tutorialText: 'tutorial__6_text'.tr,
      last: true,
    );
  }
}

class _Tuto6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TutorialContentWithoutImage(
      titleText: 'tutorial__6_title'.tr,
      text: 'tutorial__6_text'.tr,
      subText: 'tutorial__6_subtext'.tr,
    );
  }
}
