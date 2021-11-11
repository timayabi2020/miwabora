import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/constants.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FaqState extends StatefulWidget {
  String? title;
  String? catId;
  FaqState({Key? key, this.catId, this.title}) : super(key: key);

  @override
  _FaqState createState() => _FaqState(title, catId);
}

class _FaqState extends State<FaqState> {
  List categories = [];
  bool loading = true;
  String? _title;
  String? _catId;
  _FaqState(String? title, String? catId) {
    this._catId = catId;
    this._title = title;
  }
  @override
  void initState() {
    getData().then((data) {
      setState(() {
        categories = data;
      });
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
          appBar: AppBar(
            title: Text("FAQ Questions",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    child: Image.asset(
                  "assets/images/logobora.png",
                  width: 250,
                )),
                Container(
                  child: Text(
                    _title.toString() + " Category",
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: ListView.builder(
                    /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),*/
                    itemBuilder: (context, position) {
                      return ExpandablePanel(
                        header: Text(categories[position]["question"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        collapsed: Text(""),
                        expanded: Text(
                          categories[position]["answer"],
                          softWrap: true,
                        ),
                        theme: ExpandableThemeData(
                            hasIcon: true, tapHeaderToExpand: true),
                      );
                    },
                    itemCount: categories.length,
                  ),
                ),
              ],
            ),
          )),
      Center(
          child: Visibility(
        visible: loading,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
      ))
    ]);
  }

  fetchfaqs() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res =
        await http.get(Uri.parse(FAQ_QUESTIONS), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("faq", res.body);
      List<dynamic> data = map["data"];
      //filter before returning data.
      List<dynamic> filteredData = data
          .where((e) => e["category"]["id"].toString() == _catId.toString())
          .toList();
      loading = false;
      setState(() {
        categories = filteredData;
      });
      return filteredData;
    }
  }

  Future<List> getData() async {
    List<dynamic> filteredData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("faq") == null) {
      fetchfaqs().then((data) {
        setState(() {
          categories = data;
        });
      });
    } else {
      setState(() {
        loading = true;
      });
      String storedData = prefs.getString("faq").toString();
      Map<String, dynamic> map = json.decode(storedData);
      List<dynamic> data = map["data"];

      //filter before returning data.
      filteredData = data
          .where((e) => e["category"]["id"].toString() == _catId.toString())
          .toList();
      setState(() {
        loading = false;
      });
    }
    return filteredData;
  }
}
