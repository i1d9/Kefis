import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  final String title;
  final Widget child;

  const TestView({Key? key, required this.child, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(children: [Text(title), child],),
    );
  }
}
