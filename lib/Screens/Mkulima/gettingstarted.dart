import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/constants.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({Key? key}) : super(key: key);

  @override
  _GettingStartedPageState createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  List establishment = [];
  bool loading = true;
  @override
  void initState() {
    fetchFarmings().then((data) {
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
                    child: establishment.length == 0
                        ? Image.asset(
                            "assets/images/ic_miwa_logo.png",
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
                          child: establishment.length == 0
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
      List<dynamic> data = map["data"];

      //filter before returning data.
      List<dynamic> filteredData =
          data.where((e) => e["category"].toString() == "mkulima").toList();
      loading = false;
      return filteredData;
    }
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
}
