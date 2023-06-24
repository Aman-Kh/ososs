import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationView extends StatelessWidget {
  const AnimationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
