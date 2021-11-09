import 'package:flutter/material.dart';
import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/Screens/Profile/other_profile.dart';
import 'package:miwabora/Screens/Profile/profile_farmer.dart';
import 'package:miwabora/Screens/Profile/profile_miller.dart';
import 'package:miwabora/Screens/Profile/profile_trader.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';

class ProfileBrief extends StatefulWidget {
  Map<String, dynamic>? resultsMap;
  ProfileBrief(Map<String, dynamic> details) {
    this.resultsMap = details;
  }
  @override
  _ProfileBriefState createState() => _ProfileBriefState(resultsMap);
}

class _ProfileBriefState extends State<ProfileBrief> {
  Map<String, dynamic>? details;
  String? _username;
  String? _phone;
  String? _email;
  String? _userId;
  String? _role;
  _ProfileBriefState(Map<String, dynamic>? resultsMap) {
    this.details = resultsMap;
  }

  @override
  void initState() {
    _extractDetails();
    //
  }

  void _extractDetails() {
    String? username = this.details!["username"];
    String? userId = this.details!["userid"];
    String? phone = this.details!["phone"];
    String? email = this.details!["email"];
    String? role = this.details!["role"];

    print("Role" + role.toString() + "User name " + username.toString());

    setState(() {
      _username = username;
      _email = email;
      _phone = phone;
      _userId = userId;
      _role = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover))),
      Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                //padding: EdgeInsets.only(left: size.width * 0.05),
                //alignment: Alignment.centerLeft,
                child: Text("Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: size.width * 0.3),
              Container(
                // padding: EdgeInsets.only(left: size.width * 0.20),
                // alignment: Alignment.topRight,

                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    //size: 40,
                  ),
                  color: Colors.white,
                  onPressed: () => navigateToProfile(context),
                ),
              )
            ]),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(

              //constraints: BoxConstraints.expand(),
              child: Container(
            color: Colors.transparent,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: OutlinedButton(
                  onPressed: () {},
                  //child: Text('Button'),
                  style: OutlinedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(40),
                    backgroundColor: kPrimaryColor,
                    side: BorderSide(color: kPrimaryColor, width: 1),
                  ),
                  child: Text(
                    _username!.characters
                        .characterAt(0)
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
                SizedBox(height: size.height * 0.05),
                Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 2,
                    child: Container(
                        child: Column(children: [
                      // Text(products[index]["name"]),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              "Name",
                              maxLines: 15,
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              _username.toString(),
                              maxLines: 15,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      buildDivider(),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              "Phone",
                              maxLines: 15,
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              _phone.toString(),
                              maxLines: 15,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      buildDivider(),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              "Email",
                              maxLines: 15,
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              _email.toString(),
                              maxLines: 15,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                    ]))),
                RoundedButton(
                  text: "LOG OUT",
                  color: kPrimaryColor,
                  sizeval: 0.7,
                  press: () {
                    //  buildShowDialog(context);
                    logoutAlertDialog(context);
                  },
                ),
                // SizedBox(height: size.height * 0.05),
              ],
            ),
          )
// This trailing comma makes auto-formatting nicer for build methods.
              ))
    ]);
  }

  logoutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("LOGOUT", style: TextStyle(color: kPrimaryColor)),
      onPressed: () {
        navigateToLogin(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert!",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (route) => false,
    );
  }

  void navigateToProfile(BuildContext context) {
    print('ROle ' + _role.toString());
    if (_role.toString() == "Farmer") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UpdateFarmerRegistrationPage(details!);
          },
        ),
      );
    } else if (_role.toString() == "Investor") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UpdateMillerRegistrationPage(details!);
          },
        ),
      );
    } else if (_role == "Trader") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UpdateTraderrRegistrationPage(details!);
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UpdateOtherRegistrationPage(details!);
          },
        ),
      );
    }
  }

  buildDivider() {
    return Divider(
      color: Colors.black,
      height: 10,
      thickness: 1.5,
    );
  }
}
