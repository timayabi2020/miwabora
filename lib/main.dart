import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miwabora/Screens/Dashboard/dashboard.dart';
import 'dart:async';

import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      theme: ThemeData(primaryColor: kPrimaryColor),
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
              getData()
            });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splashimage.png"),
                  fit: BoxFit.cover))),
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned.fill(
                child: isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white70),
                        ))
                    : Text(''))
          ]))
    ]);
  }

  getData() async {
    //Check if user is logged in
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("logged_in") == true) {
      Map<String, dynamic> resultsMap =
          jsonDecode(prefs.getString("profile_data").toString());

      // print("Logged " + resultsMap.toString());
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(resultsMap)));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    }
  }
}
