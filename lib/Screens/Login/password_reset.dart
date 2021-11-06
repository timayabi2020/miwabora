import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Dashboard/dashboard.dart';
import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/Screens/Registration/farmer_registration.dart';
import 'package:miwabora/Screens/Registration/miller_register.dart';
import 'package:miwabora/Screens/Registration/other.dart';
import 'package:miwabora/Screens/Registration/trader_registration.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  String _username = '';

  @override
  void initState() {}

  void _emailChange(String text) {
    setState(() {
      _username = text;
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
            title: Text("Reset Password"),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(

              //constraints: BoxConstraints.expand(),
              child: Container(
            color: Colors.transparent,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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

                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "RESET PASSWORD",
                  color: kPrimaryColor,
                  sizeval: 0.7,
                  press: () {
                    //  buildShowDialog(context);
                    resetDialog(context);
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

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  resetDialog(BuildContext context) {
    if (this._username == "") {
      apiErrorShowDialog(context, "Please enter user name");
    } else {
      Future<Response> result = submit(_username.toString(), context);
      result.then((response) {
        if (response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print("Got responsecode " + response.statusCode.toString());
          Navigator.of(context, rootNavigator: true).pop();
          PasswordReset result =
              PasswordReset.fromJson(jsonDecode(response.body));
          if (result.success == false) {
            apiErrorShowDialog(context, result.message.toString());
          } else {
            //set everything to null

            setState(() {
              this._username = "";
            });

            //put every thing into a map and navigate to dashboard
            apiSuccessShowDialog(context, result.message.toString());
          }
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          String message = PasswordReset.fromJson(jsonDecode(response.body))
              .message
              .toString();
          print("Message " + message);
          Navigator.of(context, rootNavigator: true).pop();
          apiErrorShowDialog(context, message);
          //throw Exception('Failed to create album.');
        }
      });

      return showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  new CircularProgressIndicator(color: kPrimaryColor),
                  new Text("Submitting request ....",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0))),
                ],
              ),
            );
          });
    }
  }

  apiErrorShowDialog(BuildContext context, String message) {
    return AwesomeDialog(
            context: context,
            useRootNavigator: true,
            dialogType: DialogType.NO_HEADER,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Error',
            desc: message,
            btnOkOnPress: () {},
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
        .show();
  }

  apiSuccessShowDialog(BuildContext context, String message) {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        useRootNavigator: true,
        dialogType: DialogType.NO_HEADER,
        showCloseIcon: true,
        title: 'Succes',
        desc: message,
        btnOkOnPress: () {
          //Go back to login page
          navigateToLogin(context);
        },
        btnOkIcon: Icons.check_circle)
      ..show();
  }

  Future<Response> submit(String _username, BuildContext context) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      return await http.post(
        Uri.parse(RESET_PASSWORD),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': _username.replaceAll(' ', '')}),
      );
    } on SocketException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      apiErrorShowDialog(context,
          "Unable to process your request. Please check your internet connection");
    } on TimeoutException catch (e) {
      //treat TimeoutException
      Navigator.of(context, rootNavigator: true).pop();
      apiErrorShowDialog(context, "Connection timed out. Please try again");
    } catch (e) {
      // Navigator.pop(context);
      apiErrorShowDialog(context, "An error occured. Please try again later");
    }
    throw Exception('Failed to create album.');
  }
}

class PasswordReset {
  final bool? success;
  final String? message;

  PasswordReset({this.message, this.success});
  factory PasswordReset.fromJson(Map<String, dynamic> json) {
    return PasswordReset(
      success: json['success'],
      message: json['message'],
    );
  }
}
