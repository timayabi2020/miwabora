import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Network/network.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key}) : super(key: key);

  @override
  _GettingStartedPageState createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  List establishment = [];
  bool loading = true;
  bool internetCheck = false;
  @override
  void initState() {
    networkCheck();
    getData().then((data) {
      setState(() {
        establishment = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Scaffold(
          appBar: AppBar(
            title: Text("Getting started",
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
                    child: this.internetCheck == false ||
                            establishment == null ||
                            establishment.length == 0
                        ? Image.asset(
                            "assets/images/logobora.png",
                            width: 250,
                          )
                        : Image.network(
                            establishment[0]['picture'][0]['url'],
                            width: size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 2,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Description",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child:
                              establishment == null || establishment.length == 0
                                  ? Text("Loading...")
                                  : Html(data: establishment[0]['description']))
                    ]))
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

  Future fetchFarmings() async {
    loading = true;
    List<dynamic> filteredData = [];
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var res = await http
          .get(Uri.parse(SUGARCANE_ESTABLISHMENT), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'AppBearer ' + token,
      });
      if (res.statusCode == 200) {
        //var obj = json.decode(res.body);
        Map<String, dynamic> map = json.decode(res.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("getting_started", res.body);
        List<dynamic> data = map["data"];

        //filter before returning data.
        filteredData =
            data.where((e) => e["category"].toString() == "mkulima").toList();
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

    if (prefs.getString("getting_started") == null) {
      fetchFarmings().then((data) {
        setState(() {
          establishment = data;
        });
      });
    } else {
      setState(() {
        loading = true;
      });
      String storedData = prefs.getString("getting_started").toString();
      Map<String, dynamic> map = json.decode(storedData);
      List<dynamic> data = map["data"];

      //filter before returning data.
      filteredData =
          data.where((e) => e["category"].toString() == "mkulima").toList();
      setState(() {
        loading = false;
      });
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
            internetCheck: internetCheck,
          );
        },
      ),
    );
  }

  confirmInternet(BuildContext context) async {
    await networkCheck();
    Navigator.of(context).pop();
  }

  networkCheck() async {
    NetworkCheck networkCheck = new NetworkCheck();
    bool check = await networkCheck.check();

    _networkconnectionChange(check);
  }

  void _networkconnectionChange(bool internet) {
    setState(() {
      internetCheck = internet;
    });
  }

  showNetworkError(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Connectivity Error"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Please check your internet connection and try again"),
                  RoundedButton(
                    text: "CANCEL",
                    sizeval: 0.7,
                    color: kPrimaryColor,
                    press: () {
                      //navigateToDashBoard(context);
                      confirmInternet(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
