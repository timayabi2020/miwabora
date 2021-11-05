import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Dashboard/dashboard.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';

class ComplaintsPage extends StatefulWidget {
  String? userId;
  String? username;
  String? email;
  Map<String, String>? resultsMap;
  ComplaintsPage(String userId, String username, String email,
      Map<String, String> details) {
    this.userId = userId;
    this.username = username;
    this.email = email;
    this.resultsMap = details;
  }

  @override
  _ComplaintsPageState createState() =>
      _ComplaintsPageState(this.userId.toString(), resultsMap);
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  Map<String, String>? details;
  String _user_id = "";
  String _complaint = "";
  String _subject = "";
  _ComplaintsPageState(String userId, Map<String, String>? resultsMap) {
    this._user_id = userId;
    this.details = resultsMap;
  }

  @override
  void initState() {}

  void _subjectChange(String text) {
    setState(() {
      _subject = text;
    });
  }

  void _complaintsChange(String text) {
    setState(() {
      _complaint = text;
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
            title: Text("Raise complaint"),
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
                          labelText: 'Subject',
                          hintText: 'Subject here ...'),
                      onChanged: (value) {
                        _subjectChange(value);
                      },
                    )),
                SizedBox(height: size.height * 0.05),
                Container(
                    padding: EdgeInsets.only(
                        left: size.width * 0.10, right: size.width * 0.10),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 400,
                      autofocus: true,
                      //minLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: kPrimaryColor)),
                        labelText: 'Comment goes here',
                      ),
                      onChanged: (val) {
                        setState(
                          () {
                            _complaint = val;
                          },
                        );
                      },
                    )),

                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "SUBMIT",
                  press: () {
                    //  buildShowDialog(context);
                    raiseComplaint(context);
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

  raiseComplaint(BuildContext context) {
    if (this._subject == "") {
      apiErrorShowDialog(context, "Please enter a subject");
    } else if (this._complaint == "") {
      apiErrorShowDialog(context, "Please enter a complaint");
    } else {
      Future<Response> result = submit(_subject.toString(),
          _complaint.toString(), _user_id.toString(), context);
      result.then((response) {
        if (response.statusCode == 200) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          print("Got responsecode " + response.statusCode.toString());
          Navigator.of(context, rootNavigator: true).pop();

          //put every thing into a map and navigate to dashboard
          apiSuccessShowDialog(context,
              "Complaint has successfully been raised. Please check your email for further instructions");
        } else {
          // If the server did not return a 201 CREATED response,
          Navigator.of(context, rootNavigator: true).pop();
          apiErrorShowDialog(
              context, "Service encountered an error. Please try again later");
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
                  new Text("Submitting request. Please wait ....",
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
          navigateToDashboard(context);
        },
        btnOkIcon: Icons.check_circle)
      ..show();
  }

  Future<Response> submit(String _username, String _complaint, String _userId,
      BuildContext context) async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    try {
      return await http.post(
        Uri.parse(COMPLAIN),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'subject': _subject,
          'complain': _complaint,
          'raised_by_id': _userId
        }),
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

  void navigateToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Dashboard(this.details!);
        },
      ),
    );
  }
}
