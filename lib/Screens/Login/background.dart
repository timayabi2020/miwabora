import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  late Widget child;
  Background(Widget child) {
    this.child = child;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
              child: Align(
            child: Image.asset(
              "assets/images/background.png",
              //fit: BoxFit.fill,
              width: size.width * 1,
              //: size.height * 0.9,
            ),
          )),
          child,
        ],
      ),
    );
  }
}
