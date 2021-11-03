import 'package:flutter/material.dart';
import 'dart:async';

import 'package:miwabora/Screens/Login/login.dart';

void main() {
  runApp(MyApp());
}

bool isLoading = true;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 8),
        () => {
              setState(() {
                isLoading = false; //set loading to false
              }),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage()))
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Center(
            child: Image.asset("assets/images/splashimage.png"),
          ),
          Positioned.fill(
              child: isLoading
                  ? Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white70),
                      ))
                  : Text(''))
        ]));
  }
}
