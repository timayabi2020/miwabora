import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Help/faq.dart';
import 'package:miwabora/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  List categories = [];
  bool loading = true;
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
            title: Text("Help",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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
                    "FAQ Categories",
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
                      return GestureDetector(
                        onTap: () {
                          moreDetails(position, context);
                        },
                        child: Card(
                          semanticContainer: true,
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        child: Text(
                                            categories[position]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        onPressed: () {
                                          moreDetails(position, context);
                                        },
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
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

  fetchCategories() async {
    loading = true;
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res =
        await http.get(Uri.parse(FAQ_CATEGORIES), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("help", res.body);
      List<dynamic> data = map["data"];
      //filter before returning data.
      List<dynamic> filteredData =
          data.where((e) => e["name"] != null).toList();
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

    if (prefs.getString("help") == null) {
      fetchCategories().then((data) {
        setState(() {
          categories = data;
        });
      });
    } else {
      setState(() {
        loading = true;
      });
      String storedData = prefs.getString("help").toString();
      Map<String, dynamic> map = json.decode(storedData);
      List<dynamic> data = map["data"];

      //filter before returning data.
      filteredData = data.where((e) => e["name"] != null).toList();
      setState(() {
        loading = false;
      });
    }
    return filteredData;
  }

  void moreDetails(int index, BuildContext context) {
    String title = categories[index]["name"];
    String catId = categories[index]['id'].toString();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FaqState(
            title: title,
            catId: catId,
          );
        },
      ),
    );
  }
}
