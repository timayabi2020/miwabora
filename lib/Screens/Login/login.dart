import 'package:flutter/material.dart';
import 'package:miwabora/Screens/Registration/farmer_registration.dart';
import 'package:miwabora/Screens/Registration/miller_register.dart';
import 'package:miwabora/Screens/Registration/other.dart';
import 'package:miwabora/Screens/Registration/trader_registration.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _newPassword = '';
  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = !_passwordVisible;
  }

  void _emailChange(String text) {
    setState(() {
      _username = text;
    });
  }

  void _newPasswordChange(String text) {
    setState(() {
      _newPassword = text;
    });
  }

  void _confirmPasswordChange(String text) {
    setState(() {
      _confirmPassword = text;
    });
    print('text' + text);
  }

  void _passwordChange(String text) {
    setState(() {
      _password = text;
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
          body: SingleChildScrollView(

              //constraints: BoxConstraints.expand(),
              child: Container(
            color: Colors.transparent,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ic_miwa_logo.png",
                      width: 250,
                    )),
                Text(
                  'Welcome!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                // SizedBox(height: size.height * 0.03),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: TextFormField(
                      autofocus: true,
                      cursorColor: kPrimaryColor,
                      minLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor)),
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: kPrimaryColor),
                          labelText: 'Username*',
                          hintText: 'Phone number or email'),
                      onChanged: (value) {
                        _emailChange(value);
                      },
                    )),
                // SizedBox(height: size.height * 0.05),
                Container(
                  padding: EdgeInsets.only(
                      left: size.width * 0.10, right: size.width * 0.10),
                  child: TextFormField(
                    autofocus: true,
                    minLines: 1,
                    cursorColor: kPrimaryColor,
                    obscureText: _passwordVisible,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kPrimaryColor)),
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kPrimaryColor),
                      hintText: 'Password here...',
                      labelText: 'Password*',
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      _passwordChange(value);
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: ResetPassword(
                      press: () {
                        //forgotPasswordAlertDialog(context);
                      },
                      text: 'Forgot password?',
                    )),
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    //  buildShowDialog(context);
                  },
                ),
                // SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "NEW USER? REGISTER",
                  press: () {
                    //  buildShowDialog(context);
                    registrationOptions(context, size);
                  },
                )
              ],
            ),
          )
// This trailing comma makes auto-formatting nicer for build methods.
              ))
    ]);
  }

  registrationOptions(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Select type of user"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: RoundedButton(
                        text: "FARMER REGISTER",
                        press: () {
                          navigateToFarmerRegistration(context);
                          //confirmInternet(context);
                        },
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: RoundedButton(
                        text: "TRADER REGISTER",
                        press: () {
                          navigateToTraderrRegistration(context);
                        },
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: RoundedButton(
                        text: "MILLER REGISTER",
                        press: () {
                          navigateToMillerRegistration(context);
                          //confirmInternet(context);
                        },
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: RoundedButton(
                        text: "OTHER REGISTER",
                        press: () {
                          navigateToOtherRegistration(context);
                          //confirmInternet(context);
                        },
                      )),
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      Expanded(
                          child: ResetPassword(
                        press: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void navigateToFarmerRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FarmerRegistrationPage();
        },
      ),
    );
  }

  void navigateToTraderrRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TraderRegistrationPage();
        },
      ),
    );
  }

  void navigateToMillerRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MillerRegistrationPage();
        },
      ),
    );
  }

  void navigateToOtherRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OtherRegistrationPage();
        },
      ),
    );
  }
}
