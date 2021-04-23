import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String message;

  EmptyList(this.message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(message),
      ),
    );
  }
}
