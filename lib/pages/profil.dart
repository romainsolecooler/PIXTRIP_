import 'package:flutter/material.dart';
import 'package:pixtrip/common/app_bar.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text('NM'),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Nathan Martzolff',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Expanded(child: SizedBox()),
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => print('Go to profil settings'),
                  ),
                ],
              ),
            ),
            ProfilList(),
          ],
        ),
      ),
    );
  }
}

class ProfilList extends StatelessWidget {
  final double _spacing = 15.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2 - 20;
    int max = 51;

    List<Widget> children = [];

    for (int i = 0; i < max; i++) {
      children.add(ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: screenWidth,
          height: screenWidth,
          child: InkWell(
            onTap: () => print('show trip from profil'),
            child: Placeholder(),
          ),
        ),
      ));
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          children: children,
          spacing: _spacing,
          runSpacing: _spacing,
        ),
      ),
    );
  }
}
