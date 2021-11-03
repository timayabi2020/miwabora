import 'package:flutter/material.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/components/rounded_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  String _confirmPassword = '';
  String _newPassword = '';
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
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      //constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
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
                minLines: 1,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                obscureText: true,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    hintText: 'Password here...',
                    labelText: 'Password*',
                    fillColor: Colors.white),
                onChanged: (value) {
                  _passwordChange(value);
                },
              )),
          SizedBox(height: size.height * 0.05),
          Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.10, right: size.width * 0.10),
              child: ResetPassword(
                press: () {
                  //forgotPasswordAlertDialog(context);
                },
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
            },
          )
        ],
      ),
    )
// This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
