import 'package:flutter/material.dart';

Map<String, int> social = {
  'apple': 0xff000000,
  'google': 0xffffffff,
  'facebook': 0xff3b5998,
  'twitter': 0xff1da1f2,
  'whatsapp': 0xff25D366,
};

class SocialButton extends StatelessWidget {
  final String name;
  final Function function;

  const SocialButton({
    Key key,
    @required this.function,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Material(
        elevation: 2.0,
        color: Color(social[name]),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(
            'assets/images/social/$name.png',
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
