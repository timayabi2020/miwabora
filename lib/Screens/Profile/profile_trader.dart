import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';

class UpdateTraderrRegistrationPage extends StatefulWidget {
  Map<String, String>? resultsMap;
  UpdateTraderrRegistrationPage(Map<String, String> details) {
    this.resultsMap = details;
  }

  @override
  _UpdateTraderRegistrationPageState createState() =>
      _UpdateTraderRegistrationPageState(resultsMap);
}

class _UpdateTraderRegistrationPageState
    extends State<UpdateTraderrRegistrationPage> {
  String? _traderProducts;
  String? _userId;
  bool loading = true;
  String? _type;
  List counties = [];
  List millers = [];
  List sub_counties = [];
  List filtererd_subcounties = [];
  List zones = [];
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _newPassword;
  String? _town;
  String? _phone;
  String? _name;
  bool _passwordVisible = true;
  bool _confirmpasswordVisible = true;
  List selectedProducts = [];
  Map<String, String>? details;

  _UpdateTraderRegistrationPageState(Map<String, String>? resultsMap) {
    this.details = resultsMap;
  }

  @override
  void initState() {
    _passwordVisible = !_passwordVisible;
    _confirmpasswordVisible = !_confirmpasswordVisible;

    _extractDetails();
  }

  void _emailChange(String text) {
    setState(() {
      _email = text;
    });
  }

  void _nameChange(String text) {
    setState(() {
      _name = text;
    });
  }

  void _newPasswordChange(String text) {
    setState(() {
      _password = text;
    });
  }

  void _confirmPasswordChange(String text) {
    setState(() {
      _confirmPassword = text;
    });
    print('text' + text);
  }

  void _phoneChange(String text) {
    setState(() {
      _phone = text;
    });
  }

  void _townChange(String text) {
    setState(() {
      _town = text;
    });
  }

  List products = [
    {
      'name': 'Sugar',
    },
    {'name': 'Molasses'},
    {'name': 'Jaggery'},
    {'name': 'Ethanol'},
    {'name': 'Other'}
  ];

  bool isSearching = false;
  var holder_1 = [];

  _extractDetails() async {
    String? username = this.details!["username"];
    String? userId = this.details!["userid"];
    String? phone = this.details!["phone"];
    String? email = this.details!["email"];
    String? type = this.details!["trader_type"];
    String? products = this.details!["trader_products"];
    String? trader_town = this.details!["town"];

    List<String> preloaded = products!.split(',');

    setState(() {
      _name = username;
      _email = email;
      _phone = phone;
      _userId = userId;
      _type = type;
      selectedProducts = preloaded;
      _town = trader_town;
    });
    //this.selectedCounty(county!);
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
            title: Text("Profile"),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Text(
                  'Update profile',
                  style: TextStyle(fontSize: 20),
                ),
                Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: TextFormField(
                            autofocus: true,
                            cursorColor: kPrimaryColor,
                            minLines: 1,
                            initialValue: _name,
                            keyboardType: TextInputType.text,
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
                                labelText: 'Business Name*',
                                hintText: 'e.g John Doe'),
                            onChanged: (value) {
                              _nameChange(value);
                            },
                          )))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: TextFormField(
                            autofocus: true,
                            initialValue: _phone,
                            cursorColor: kPrimaryColor,
                            minLines: 1,
                            keyboardType: TextInputType.number,
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
                                labelText: 'Phone*',
                                hintText: 'e.g 0700112223'),
                            onChanged: (value) {
                              _phoneChange(value);
                            },
                          )))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: TextFormField(
                            autofocus: true,
                            cursorColor: kPrimaryColor,
                            minLines: 1,
                            initialValue: _email,
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
                                labelText: 'Email*',
                                hintText: 'e.g john@gmail.com'),
                            onChanged: (value) {
                              _emailChange(value);
                            },
                          )))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
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
                        hintText: 'Minimum 4 characters',
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
                        _newPasswordChange(value);
                      },
                    ),
                  ))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
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
                        hintText: 'Minimum 4 characters',
                        labelText: 'Confirm Password*',
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
                        _confirmPasswordChange(value);
                      },
                    ),
                  ))
                ]),
                Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: TextFormField(
                            autofocus: true,
                            cursorColor: kPrimaryColor,
                            minLines: 1,
                            initialValue: _town,
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
                                labelText: 'Town*',
                                hintText: 'e.g Kitengela, Machakos ...'),
                            onChanged: (value) {
                              _townChange(value);
                            },
                          )))
                ]),
                SizedBox(height: size.height * 0.03),
                Row(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: Text("Type *"),
                  )),
                ]),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: DropdownButton(
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black),
                            items: [
                              'Wholesaler',
                              'Retailer',
                              'Importer',
                              'Other'
                            ].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _type = val.toString();
                                },
                              );
                            },
                            value: _type,
                          )),
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: Text("Products *"),
                  )),
                ]),
                SizedBox(height: size.height * 0.03),
                Row(children: [
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(
                              left: size.width * 0.10,
                              right: size.width * 0.10),
                          child: Column(
                            children: <Widget>[
                              GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .width /
                                        (MediaQuery.of(context).size.height /
                                            8),
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                        color: Colors.white,
                                        // color: Color.fromRGBO(138, 170, 243, 0.5),

                                        elevation: 2,
                                        child: Container(
                                            child: Row(children: [
                                          // Text(products[index]["name"]),
                                          Checkbox(
                                            shape: CircleBorder(),
                                            value: selectedProducts.contains(
                                                products[index]["name"]),
                                            onChanged: (value) {
                                              if (selectedProducts.contains(
                                                  products[index]["name"])) {
                                                selectedProducts.remove(
                                                    products[index]
                                                        ["name"]); // unselect
                                              } else {
                                                selectedProducts.add(
                                                    products[index]
                                                        ["name"]); // select
                                              }
                                              setState(() {});
                                            },
                                            checkColor: Colors.white,
                                            //inactiveColor: Colors.white,
                                            activeColor: kPrimaryColor,
                                          ),

                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Center(
                                              child: Text(
                                                "${products[index]['name']}",
                                                maxLines: 15,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        30, 67, 136, 1)),
                                              ),
                                            ),
                                          ),
                                        ])));
                                  })
                            ],
                          )))
                ]),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: RoundedButton(
                          text: "CANCEL",
                          sizeval: 0.40,
                          color: Colors.grey,
                          press: () {
                            // registerDialog(context);
                            //confirmInternet(context);
                          },
                        )),
                    SizedBox(width: size.height * 0.03),
                    Container(
                        child: RoundedButton(
                      text: "UPDATE",
                      sizeval: 0.40,
                      color: kPrimaryColor,
                      press: () {
                        registerDialog(context);
                        //confirmInternet(context);
                      },
                    ))
                  ],
                ),
              ]))),
    ]);
  }

  registerDialog(BuildContext context) {
    if (_name == null || this._name == "") {
      apiErrorShowDialog(context, "Please enter name");
    } else if (_phone == null || this._phone == "") {
      apiErrorShowDialog(context, "Please enter phone number");
    } else if (this._type == "") {
      apiErrorShowDialog(context, "Please select type");
    } else if (_password == null || this._password == "") {
      apiErrorShowDialog(context, "Please enter password");
    } else if (selectedProducts.length < 1) {
      apiErrorShowDialog(context, "Please select a product");
    } else if (checkPassLength(this._password.toString()) == true) {
      apiErrorShowDialog(
          context, "Please enter password. Minimum of four characters");
    } else if (this._password.toString() != this._confirmPassword.toString()) {
      apiErrorShowDialog(
          context, "Password mismatch. Kindly confirm your password again");
    } else if (validateEmail(_email.toString()) == false) {
      apiErrorShowDialog(context, "Please enter a valid email address");
    } else {
      Future<Response> result = submit(
          _name.toString(),
          _phone.toString(),
          _email.toString(),
          _password.toString(),
          _confirmPassword.toString(),
          _town.toString(),
          _type.toString(),
          selectedProducts,
          context);
      result.then((response) {
        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print("Got responsecode " + response.statusCode.toString());
          Navigator.of(context, rootNavigator: true).pop();
          Registration result =
              Registration.fromJson(jsonDecode(response.body));
          if (result.statuscode != 200) {
            apiErrorShowDialog(context,
                "Service encountered an error. Please try again later");
          } else {
            apiSuccessShowDialog(context, result.success.toString());
          }
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          String message =
              "Service encountered an error. Please try again later";
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
                  new CircularProgressIndicator(),
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
        title: "Success",
        desc: message,
        btnOkOnPress: () {
          //Go back to login page
          navigateToLogin(context);
        },
        btnOkIcon: Icons.check_circle)
      ..show();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (route) => false,
    );
  }

  Future<Response> submit(
      String _name,
      String _phone,
      String _email,
      String _password,
      String _confirmPassword,
      String _town,
      String _type,
      List _traderProducts,
      BuildContext context) async {
    String actualProducts = "";
    int counter = 0;
    _traderProducts.forEach((element) {
      actualProducts += element;
      if (counter < _traderProducts.length) {
        actualProducts += ",";
      }
      counter++;
    });
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    String payload = UPDATE_PROFILE +
        "?id=" +
        _userId.toString() +
        "&name=" +
        _name +
        "&ward=" +
        _phone +
        "&email=" +
        _email +
        "&password=" +
        _password +
        "&town=" +
        _town +
        "&trader_products=" +
        actualProducts.toString() +
        "&trader_type=" +
        _type;
    print(payload);
    try {
      return await http.post(
        Uri.parse(payload),
        headers: <String, String>{
          'Content-Type': 'text/plain',
        },
        //body:null
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

  bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool checkPassLength(String value) {
    print("Val length " + value.length.toString());
    // bool result = false;
    int strLength = value.length;
    if (strLength > 3) {
      print("Retutning false ");
      return false;
    }

    return true;
  }
}

class Registration {
  final String? success;
  final String? result;
  final int? statuscode;
  Registration({this.success, this.result, this.statuscode});
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
        success: json['success'],
        result: json['result'],
        statuscode: json['statuscode']);
  }
}
