import 'dart:convert';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/constants.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OfficersPage extends StatefulWidget {
  String? millerId;
  OfficersPage(String id) {
    this.millerId = id;
  }
  @override
  _OfficersPageState createState() => _OfficersPageState(millerId);
}

class _OfficersPageState extends State<OfficersPage> {
  List establishment = [];
  bool loading = true;
  String? _miller_id;
  _OfficersPageState(String? id) {
    this._miller_id = id;
  }

  @override
  void initState() {
    getData().then((data) {
      setState(() {
        establishment = data;
      });
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var platform = Theme.of(context).platform;
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
              title: Row(children: [
                Flexible(
                  child: Text("Extension Officer",
                      maxLines: 15,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                )
              ]),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    //size: 40,
                  ),
                  color: Colors.white,
                  onPressed: () => {
                    fetchFarmings().then((data) {
                      setState(() {
                        establishment = data;
                      });
                    })
                  },
                )
              ]),
          body: SingleChildScrollView(

              //constraints: BoxConstraints.expand(),
              child: Container(
            color: Colors.transparent,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Card(
                    child: Container(
                        child: Column(children: [
                  Center(
                    child: Text(
                      "Company Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: establishment.length == 0
                              ? Text("No data available")
                              : Text(
                                  "${establishment[0]["company"]["company_name"]}",
                                  maxLines: 15,
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: establishment.length == 0
                              ? Text("No data available")
                              : Text(
                                  "${establishment[0]["company"]["company_website"]}",
                                  maxLines: 15,
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: establishment.length == 0
                              ? Text("No data available")
                              : Text(
                                  "${establishment[0]["company"]["company_email"]}",
                                  maxLines: 15,
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                        ),
                      ),
                    ],
                  ),
                ]))),
                Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 2,
                    child: Container(
                        child: Column(children: [
                      Center(
                        child: Text("Extension Officer",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: size.height * 0.05),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: establishment.length == 0
                                ? Text("No data available")
                                : Text(
                                    "${establishment[0]["contact_first_name"]}" +
                                        " " +
                                        "${establishment[0]["contact_last_name"]}",
                                    maxLines: 15,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              "",
                              maxLines: 15,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: establishment.length == 0
                                ? Text("No data available")
                                : Text(
                                    "${establishment[0]["contact_phone_1"]}",
                                    // "Western",
                                    maxLines: 15,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: establishment.length == 0
                                ? Text("")
                                : IconButton(
                                    icon: Icon(Icons.call
                                        //size: 40,
                                        ),
                                    color: Colors.green,
                                    onPressed: () => {
                                      callOfficer(
                                          establishment[0]["contact_phone_1"])
                                    },
                                  ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: establishment.length == 0
                                ? Text("No data available")
                                : Text(
                                    "${establishment[0]["contact_phone_1"]}",
                                    //"Ok",
                                    maxLines: 15,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                              child: establishment.length == 0
                                  ? Text("")
                                  : IconButton(
                                      icon: Icon(Icons.call
                                          //size: 40,
                                          ),
                                      color: Colors.green,
                                      onPressed: () => {
                                        callOfficer(
                                            establishment[0]["contact_phone_1"])
                                      },
                                    )),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: establishment.length == 0
                                ? Text("No data available")
                                : Text(
                                    "${establishment[0]["contact_email"]}",
                                    //"Ok",
                                    maxLines: 15,
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                              child: establishment.length == 0
                                  ? Text("")
                                  : IconButton(
                                      icon: Icon(Icons.email
                                          //size: 40,
                                          ),
                                      color: Colors.redAccent,
                                      onPressed: () => {
                                        sendMail(context, platform,
                                            establishment[0]["contact_email"])
                                      },
                                    )),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                    ]))),
                // SizedBox(height: size.height * 0.05),
              ],
            ),
          )
// This trailing comma makes auto-formatting nicer for build methods.
              )),
      Center(
          child: Visibility(
        visible: loading,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
      ))
    ]);
  }

  Future fetchFarmings() async {
    loading = true;
    List<dynamic> filteredData = [];
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var res = await http
          .get(Uri.parse(EXTENSION_OFFICERS), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'AppBearer ' + token,
      });
      if (res.statusCode == 200) {
        //var obj = json.decode(res.body);
        Map<String, dynamic> map = json.decode(res.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("officers", res.body);
        List<dynamic> data = map["data"];

        //filter before returning data.
        filteredData = data
            .where(
                (e) => e["company"]["id"].toString() == _miller_id.toString())
            .toList();
        loading = false;
        setState(() {
          establishment = filteredData;
        });
      }
    } catch (e) {
      loading = false;
    }
    return filteredData;
  }

  Future<List> getData() async {
    List<dynamic> filteredData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loading = true;
    try {
      if (prefs.getString("officers") == null) {
        final ioc = new HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = new IOClient(ioc);
        var res = await http
            .get(Uri.parse(EXTENSION_OFFICERS), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'AppBearer ' + token,
        });
        if (res.statusCode == 200) {
          //var obj = json.decode(res.body);
          Map<String, dynamic> map = json.decode(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("officers", res.body);
          List<dynamic> data = map["data"];

          //filter before returning data.
          filteredData = data
              .where(
                  (e) => e["company"]["id"].toString() == _miller_id.toString())
              .toList();
          loading = false;
        }
      } else {
        setState(() {
          loading = true;
        });
        String storedData = prefs.getString("officers").toString();
        Map<String, dynamic> map = json.decode(storedData);
        List<dynamic> data = map["data"];

        //filter before returning data.
        filteredData = data
            .where(
                (e) => e["company"]["id"].toString() == _miller_id.toString())
            .toList();
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      loading = false;
    }
    return filteredData;
  }

  void moreDetails(int index, BuildContext context) {
    String description = establishment[index]["description"];
    String title = establishment[index]["title"];
    String imgUrl = establishment[index]['picture'][0]['url'];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MkulimaDescriptionPage(
            text: description,
            title: title,
            url: imgUrl,
          );
        },
      ),
    );
  }

  buildDivider() {
    return Divider(
      color: Colors.black,
      height: 10,
      thickness: 1.5,
    );
  }

  buildDivider2() {
    return Divider(
      color: Colors.transparent,
      height: 10,
      thickness: 1.5,
    );
  }

  sendMail(BuildContext context, TargetPlatform platform, mailTo) {
    // if (platform == TargetPlatform.iOS) {
    /*final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mailTo,
      query: encodeQueryParameters(
          <String, String>{'subject': 'Miwa Bora Queries'}),
    );
    launch(emailLaunchUri.toString()).catchError((e) {});
    } else {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
      );
      intent.launch().catchError((e) {
        ;
      });
    }*/
    RenderBox box = context.findRenderObject()! as RenderBox;

    // final RenderBox box =context.findRenderObject() as RenderObject;
    Share.share("Mail to Extension Officer",
        subject: "Miwa Bora",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<void>? _launched;

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void callOfficer(String phone) {
    setState(() {
      _launched = _openUrl('tel:${phone}');
    });
  }
}
