import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  double _indent = 50.0;

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: _indent,
      endIndent: _indent,
    );
  }
}
