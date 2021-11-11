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

class FarmerRegistrationPage extends StatefulWidget {
  const FarmerRegistrationPage({Key? key}) : super(key: key);

  @override
  _FarmerRegistrationPageState createState() => _FarmerRegistrationPageState();
}

class _FarmerRegistrationPageState extends State<FarmerRegistrationPage> {
  String? _selectedMiller;
  String? _selectedCounty;
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
  String? _size;
  String? _phone;
  String? _name;
  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;

  @override
  void initState() {
    _passwordVisible = !_passwordVisible;
    _confirmpasswordVisible = !_confirmpasswordVisible;
    fetchCounties().then((data) {
      setState(() {
        counties = data;
      });
    });

    fetchMillers().then((data) {
      setState(() {
        millers = data;
      });
    });

    fetchSubCounties().then((data) {
      setState(() {
        sub_counties = data;
      });
    });

    fetchZones().then((data) {
      setState(() {
        zones = data;
      });
    });

    //preload sub counties with first value
    //this.selectedCounty("1");
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

  void _farmSizeChange(String text) {
    setState(() {
      _size = text;
    });
  }

  bool isSearching = false;

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

  Future fetchZones() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res = await http.get(Uri.parse(ZONES), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];
      // loading = false;
      return data;
    }
  }

  Future fetchSubCounties() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res = await http.get(Uri.parse(SUB_COUNTIES), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];
      loading = false;
      return data;
    }
  }

  Future fetchMillers() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res = await http.get(Uri.parse(MILLERS), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];
      loading = false;
      return data;
    }
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
            title: Text("Farmer Register", style: TextStyle(fontSize: 15)),
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
                                labelText: 'Size of Farm*',
                                hintText: 'Enter size in acres ...'),
                            onChanged: (value) {
                              _farmSizeChange(value);
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
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black),
                            items: ['Contracted', 'Private'].map(
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
                    child: Text("Select miller *"),
                  )),
                ]),
                millers.length != 0
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
                                  items: millers.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val['id'].toString(),
                                        child: Text(val['company_name']),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _selectedMiller = val.toString();
                                      },
                                    );
                                    //this.selectedTraining(val);
                                  },
                                  value: _selectedMiller,
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
                                child: Text("No miller data found"))),
                      ]),
                SizedBox(height: size.height * 0.03),
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
                                        value: val['name'].toString(),
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
                                    this.selectedCounty(val.toString());
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
                SizedBox(height: size.height * 0.03),
                Row(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: Text("Select a subcounty *"),
                  )),
                ]),
                filtererd_subcounties.length != 0
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
                                  items: filtererd_subcounties.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val['ward'],
                                        child: Text(
                                            val['name'] + " - " + val['ward']),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        _selectedSubCounty = val.toString();
                                      },
                                    );
                                    //this.selectedCounty(val.toString());
                                  },
                                  value: _selectedSubCounty,
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
                SizedBox(height: size.height * 0.03),
                Row(children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: Text("Select zone *"),
                  )),
                ]),
                zones.length != 0
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
                                  items: zones.map(
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
                                        _selectedZone = val.toString();
                                      },
                                    );
                                    //this.selectedTraining(val);
                                  },
                                  value: _selectedZone,
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
                                child: Text("No zone data found"))),
                      ]),
                SizedBox(height: size.height * 0.03),
                Align(
                    alignment: Alignment.center,
                    child: RoundedButton(
                      text: "REGISTER",
                      color: kPrimaryColor,
                      sizeval: 0.7,
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
                    )),
                SizedBox(height: size.height * 0.03),
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

    List filteredCounty = counties.where((c) => c["name"] == val).toList();
    String countyId = filteredCounty[0]["id"].toString();
    setState(() {
      filtererd_subcounties = sub_counties
          .where((county) => county["county_id"].toString() == countyId)
          .toList();
    });
  }

  registerDialog(BuildContext context) {
    if (_name == null || this._name == "") {
      apiErrorShowDialog(context, "Please enter name");
    } else if (_phone == null || this._phone == "") {
      apiErrorShowDialog(context, "Please enter phone number");
    } else if (_type == null || this._type == "") {
      apiErrorShowDialog(context, "Please select type");
    } else if (_size == null || this._size == "") {
      apiErrorShowDialog(context, "Please enter farm size");
    } else if (_selectedMiller == null || this._selectedMiller == "") {
      apiErrorShowDialog(context, "Please select a miller");
    } else if (_selectedCounty == null || this._selectedCounty == "") {
      apiErrorShowDialog(context, "Please select a county");
    } else if (_selectedSubCounty == null || this._selectedSubCounty == "") {
      apiErrorShowDialog(context, "Please select a sub county");
    } else if (_selectedZone == null || this._selectedZone == "") {
      apiErrorShowDialog(context, "Please select a zone");
    } else if (checkPassLength(this._password.toString()) == true) {
      apiErrorShowDialog(
          context, "Please enter password. Minimum of four characters");
    } else if (this._selectedCounty == "") {
      apiErrorShowDialog(context, "Please select a county");
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
          _size.toString(),
          _type.toString(),
          _selectedMiller.toString(),
          _selectedCounty.toString(),
          _selectedSubCounty.toString(),
          _selectedZone.toString(),
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
              this._password = null;
              this._confirmPassword = null;
              this._size = null;
              this._type = null;
              this._selectedMiller = null;
              this._selectedCounty = null;
              this._selectedSubCounty = null;
              this._selectedZone = null;
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
      String _size,
      String _type,
      String _selectedMiller,
      String _selectedCounty,
      String _selectedSubCounty,
      String _selectedZone,
      BuildContext context) async {
    List filteredSubcountyPreload = sub_counties
        .where((county) => county["ward"] == _selectedSubCounty)
        .toList();
    String subCounty = filteredSubcountyPreload[0]["name"] +
        " - " +
        filteredSubcountyPreload[0]["ward"];
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      return await http.post(
        Uri.parse(REGISTER +
            "?name=" +
            _name +
            "&ward=" +
            _phone +
            "&email=" +
            _email +
            "&county=" +
            _selectedCounty +
            "&zone_id=" +
            _selectedZone +
            "&password=" +
            _password +
            "&miller_id=" +
            _selectedMiller +
            "&sub_county=" +
            subCounty +
            "&size_of_farm=" +
            _size +
            "&farmer_types=" +
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
  final bool? success;
  final String? error;
  Registration({this.success, this.error});
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(success: json['success'], error: json['error']);
  }
}
