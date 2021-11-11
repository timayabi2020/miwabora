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

class OtherRegistrationPage extends StatefulWidget {
  const OtherRegistrationPage({Key? key}) : super(key: key);

  @override
  _OtherRegistrationPageState createState() => _OtherRegistrationPageState();
}

class _OtherRegistrationPageState extends State<OtherRegistrationPage> {
  String? _selectedMiller;
  String _selectedCounty = "30";
  String? _selectedSubCounty;
  String? _selectedZone;
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
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;
  List selectedProducts = [];

  @override
  void initState() {
    _passwordVisible = !_passwordVisible;
    _confirmpasswordVisible = !_confirmpasswordVisible;

    //preload sub counties with first value
    //this.selectedCounty("1");

    _passwordVisible = !_passwordVisible;
    _confirmpasswordVisible = !_confirmpasswordVisible;
    fetchCounties().then((data) {
      setState(() {
        counties = data;
      });
    });
  }

  Future fetchCounties() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res = await http.get(Uri.parse(COUNTIES), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];
      loading = false;
      return data;
    }
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
      _newPassword = text;
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
      'name': 'Milling',
    },
    {'name': 'Farming'},
    {'name': 'Sugar & Sugar Products'},
    {'name': 'Other'},
  ];

  bool isSearching = false;
  var holder_1 = [];

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
            title: Text("Other Register", style: TextStyle(fontSize: 15)),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Text(
                  'Create your account',
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
                                labelText: 'Name*',
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
                    child: Text("Select county *"),
                  )),
                ]),
                counties.length != 0
                    ? Row(
                        children: [
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.10,
                                    right: size.width * 0.10),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: Colors.black),
                                  items: counties.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val['id'].toString(),
                                        child: Text(val['name']),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _selectedCounty = val.toString();
                                      },
                                    );
                                    //this.selectedCounty(val.toString());
                                  },
                                  value: _selectedCounty,
                                )),
                          )
                        ],
                      )
                    : Row(children: [
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.10,
                                    right: size.width * 0.10),
                                child: Text("No county data found"))),
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

                //SizedBox(height: size.height * 0.03),
                SizedBox(height: size.height * 0.03),
                Align(
                    alignment: Alignment.center,
                    child: RoundedButton(
                      text: "REGISTER",
                      sizeval: 0.7,
                      color: kPrimaryColor,
                      press: () {
                        registerDialog(context);
                        //confirmInternet(context);
                      },
                    )),
                SizedBox(height: size.height * 0.03),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: ResetPassword(
                      press: () {
                        navigateToLogin(context);
                      },
                      text: 'Already a User? Go to Login',
                    ))
              ]))),
      Center(
          child: Visibility(
        visible: loading,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
      ))
    ]);
  }

  void selectedCounty(String val) {
    //filter subcounty depending on counties
    //CLear the nini first
    setState(() {
      filtererd_subcounties.clear();
    });
    setState(() {
      filtererd_subcounties = sub_counties
          .where(
              (county) => county["county_id"].toString().toLowerCase() == val)
          .toList();
    });
  }

  registerDialog(BuildContext context) {
    if (_name == null || this._name == "") {
      apiErrorShowDialog(context, "Please enter name");
    } else if (_phone == null || this._phone == "") {
      apiErrorShowDialog(context, "Please enter phone number");
    } else if (checkPassLength(this._newPassword.toString()) == true) {
      apiErrorShowDialog(
          context, "Please enter password. Minimum of four characters");
    } else if (this._selectedCounty == "") {
      apiErrorShowDialog(context, "Please select a county");
    } else if (this._newPassword.toString() !=
        this._confirmPassword.toString()) {
      apiErrorShowDialog(
          context, "Password mismatch. Kindly confirm your password again");
    } else if (validateEmail(_email.toString()) == false) {
      apiErrorShowDialog(context, "Please enter a valid email address");
    } else {
      Future<Response> result = submit(
          _name.toString(),
          _phone.toString(),
          _email.toString(),
          _newPassword.toString(),
          _confirmPassword.toString(),
          _selectedCounty.toString(),
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
          if (result.success == false) {
            print("Got an error " + result.error.toString());
            apiErrorShowDialog(context, result.error.toString());
          } else {
            apiSuccessShowDialog(context, result.error.toString());
            //set everything to null

            setState(() {
              this._name = null;
              this._phone = null;
              this._email = null;
              this._newPassword = null;
              this._confirmPassword = null;
              this._selectedCounty = "30";
              this._type = null;
              this.selectedProducts = [];
            });
          }
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          String message =
              Registration.fromJson(jsonDecode(response.body)).error.toString();
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
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      return await http.post(
        Uri.parse(OTHER_REGISTER +
            "?name=" +
            _name +
            "&ward=" +
            _phone +
            "&email=" +
            _email +
            "&password=" +
            _password +
            "&county=" +
            _selectedCounty.toString() +
            "&investor_products=" +
            _traderProducts.toString() +
            "&trader_type=" +
            _type),
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

int comparePasswords(String value1, String value2) {
  print("Value 1" + value1);
  print("Value 2 " + value2);
  int result = value1.trim().compareTo(value2.trim());
  print(result);
  return result;
}

class Registration {
  final bool? success;
  final String? error;
  Registration({this.success, this.error});
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(success: json['success'], error: json['error']);
  }
}
