import 'package:flutter/material.dart';
import 'package:pixtrip/common/app_bar.dart';

class ProfilDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: UserRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserImage(),
        SizedBox(width: 15.0),
      ],
    );
  }
}

class UserImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          child: Text('NM'),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () => null,
          ),
        ),
      ],
    );
  }
}
