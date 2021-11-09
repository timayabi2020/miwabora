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
import 'package:miwabora/Screens/Login/password_reset.dart';
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
  bool _passwordVisible = false;

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
          body: Container(

              //constraints: BoxConstraints.expand(),
              child: Container(
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/logobora.png",
                              width: 250,
                            )),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        // SizedBox(height: size.height * 0.03),

                        Container(
                            padding: EdgeInsets.only(
                                left: size.width * 0.10,
                                right: size.width * 0.10),
                            child: TextFormField(
                              autofocus: true,
                              cursorColor: kPrimaryColor,
                              minLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kPrimaryColor)),
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
                              left: size.width * 0.10,
                              right: size.width * 0.10),
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
                                left: size.width * 0.10,
                                right: size.width * 0.10),
                            child: ResetPassword(
                              press: () {
                                navigateToPasswordReset(context);
                              },
                              text: 'Forgot password?',
                            )),
                        SizedBox(height: size.height * 0.05),
                        RoundedButton(
                          text: "LOGIN",
                          sizeval: 0.7,
                          color: kPrimaryColor,
                          press: () {
                            //  buildShowDialog(context);
                            loginDialog(context);
                          },
                        ),
                        // SizedBox(height: size.height * 0.05),
                        RoundedButton(
                          text: "NEW USER? REGISTER",
                          sizeval: 0.7,
                          color: kPrimaryColor,
                          press: () {
                            //  buildShowDialog(context);
                            registrationOptions(context, size);
                          },
                        )
                      ],
                    ),
                  ))
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
                        sizeval: 0.7,
                        color: kPrimaryColor,
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
                        sizeval: 0.7,
                        color: kPrimaryColor,
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
                        sizeval: 0.7,
                        color: kPrimaryColor,
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
                        sizeval: 0.7,
                        color: kPrimaryColor,
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

  void navigateToDashboard(
      BuildContext context, Map<String, String> resultsMap) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Dashboard(resultsMap);
        },
      ),
    );
  }

  void navigateToPasswordReset(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PasswordResetPage();
        },
      ),
    );
  }

  loginDialog(BuildContext context) {
    if (_username == null || this._username == "") {
      apiErrorShowDialog(context, "Please enter user name");
    } else if (_password == null || this._password == "") {
      apiErrorShowDialog(context, "Please enter password");
    } else {
      Future<Response> result =
          submit(_username.toString(), _password.toString(), context);
      result.then((response) {
        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print("Got responsecode " + response.statusCode.toString());
          Navigator.of(context, rootNavigator: true).pop();
          Login result = Login.fromJson(jsonDecode(response.body));
          if (result.statuscode != 200) {
            apiErrorShowDialog(context, result.result.toString());
          } else {
            //set everything to null

            setState(() {
              this._username = "";
              this._password = "";
            });

            //put every thing into a map and navigate to dashboard
            Map<String, String> resultsMap = new HashMap();
            resultsMap.putIfAbsent("token", () => result.token.toString());
            resultsMap.putIfAbsent("userid", () => result.userid.toString());
            resultsMap.putIfAbsent("id", () => result.id.toString());
            resultsMap.putIfAbsent("town", () => result.town.toString());
            resultsMap.putIfAbsent("role_id", () => result.role_id.toString());
            resultsMap.putIfAbsent("role", () => result.role.toString());
            resultsMap.putIfAbsent("zone_id", () => result.zone_id.toString());
            resultsMap.putIfAbsent(
                "miller_id", () => result.miller_id.toString());
            resultsMap.putIfAbsent("country", () => result.country.toString());
            resultsMap.putIfAbsent("county", () => result.county.toString());
            resultsMap.putIfAbsent(
                "investor_products", () => result.investor_products.toString());
            resultsMap.putIfAbsent(
                "trader_type", () => result.trader_type.toString());
            resultsMap.putIfAbsent(
                "size_of_farm", () => result.size_of_farm.toString());
            resultsMap.putIfAbsent(
                "sub_county", () => result.sub_county.toString());
            resultsMap.putIfAbsent("phone", () => result.ward.toString());
            resultsMap.putIfAbsent(
                "farmer_types", () => result.farmer_types.toString());
            resultsMap.putIfAbsent(
                "trader_products", () => result.trader_products.toString());
            resultsMap.putIfAbsent("email", () => result.email.toString());
            resultsMap.putIfAbsent("miller", () => result.miller.toString());
            resultsMap.putIfAbsent("zone", () => result.zone.toString());
            resultsMap.putIfAbsent(
                "username", () => result.username.toString());
            navigateToDashboard(context, resultsMap);
          }
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          String message =
              Login.fromJson(jsonDecode(response.body)).result.toString();
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
        desc: "Registration was successful",
        btnOkOnPress: () {
          //Go back to login page
          navigateToLogin(context);
        },
        btnOkIcon: Icons.check_circle)
      ..show();
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

  Future<Response> submit(
      String _username, String _password, BuildContext context) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      return await http.post(
        Uri.parse(LOGIN),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _username.replaceAll(' ', ''),
          'password': _password.replaceAll(' ', '')
        }),
      );
    } on SocketException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      apiErrorShowDialog(context,
          "Unable to process your request. Please check your internet connection");
    } on TimeoutException catch (e) {
      //treat TimeoutException
      // Navigator.of(context, rootNavigator: true).pop();
      apiErrorShowDialog(context, "Connection timed out. Please try again");
    } catch (e) {
      // Navigator.pop(context);
      apiErrorShowDialog(context, "An error occured. Please try again later");
    }
    throw Exception('Failed to create album.');
  }
}

class Login {
  final int? userid;
  final int? id;
  final int? role_id;
  final int? zone_id;
  final int? miller_id;
  final int? statuscode;
  final String? town;
  final String? role;
  final String? country;
  final String? county;
  final String? investor_products;
  final String? trader_type;
  final String? size_of_farm;
  final String? sub_county;
  final String? ward;
  final String? trader_products;
  final String? email;
  final String? miller;
  final String? zone;
  final String? username;
  final String? result;
  final String? token;
  final String? farmer_types;

  Login(
      {this.userid,
      this.id,
      this.role_id,
      this.zone_id,
      this.miller_id,
      this.statuscode,
      this.town,
      this.role,
      this.country,
      this.county,
      this.investor_products,
      this.trader_type,
      this.size_of_farm,
      this.sub_county,
      this.ward,
      this.trader_products,
      this.email,
      this.miller,
      this.zone,
      this.username,
      this.result,
      this.token,
      this.farmer_types});
  factory Login.fromJson(Map<String, dynamic> json) {
    if (json['statuscode'] != 200) {
      return Login(result: json['result'], statuscode: json['statuscode']);
    }
    if (json['role'] == "Trader") {
      return Login(
          token: json['token'],
          result: json['result'],
          userid: json['userid'],
          id: json['id'],
          town: json['town'],
          role_id: json['role_id'],
          role: json['role'],
          trader_type: json['trader_type'],
          ward: json['ward'],
          trader_products: json['trader_products'],
          email: json['email'],
          username: json['username'],
          statuscode: json['statuscode']);
    } else if (json['role'] == "Investor") {
      return Login(
          token: json['token'],
          result: json['result'],
          userid: json['userid'],
          id: json['id'],
          role_id: json['role_id'],
          role: json['role'],
          country: json['country'],
          ward: json['ward'],
          investor_products: json['investor_products'],
          email: json['email'],
          username: json['username'],
          statuscode: json['statuscode']);
    } else if (json['role'] == "Farmer") {
      return Login(
          token: json['token'],
          result: json['result'],
          userid: json['userid'],
          id: json['id'],
          town: json['town'],
          role_id: json['role_id'],
          role: json['role'],
          zone_id: json['zone_id'],
          miller_id: json['miller_id'],
          country: json['country'],
          county: json['county'],
          investor_products: json['investor_products'],
          trader_type: json['trader_type'],
          size_of_farm: json['size_of_farm'],
          sub_county: json['sub_county'],
          ward: json['ward'],
          farmer_types: json['farmer_types'],
          trader_products: json['trader_products'],
          email: json['email'],
          miller: json['miller'],
          zone: json['zone'],
          username: json['username'],
          statuscode: json['statuscode']);
    } else {
      return Login(
          token: json['token'],
          result: json['result'],
          userid: json['userid'],
          id: json['id'],
          role_id: json['role_id'],
          role: json['role'],
          county: json['county'],
          ward: json['ward'],
          email: json['email'],
          username: json['username'],
          statuscode: json['statuscode']);
    }
  }
}
