import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/constants.dart';

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
    fetchFarmings().then((data) {
      setState(() {
        establishment = data;
      });
    });
  }

  @override
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
            title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                  //padding: EdgeInsets.only(left: size.width * 0.05),
                  //alignment: Alignment.centerLeft,
                  child: Flexible(
                child: Text("Extension Officer",
                    maxLines: 15,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              )),
              SizedBox(width: size.width * 0.3),
              Container(
                // padding: EdgeInsets.only(left: size.width * 0.20),
                // alignment: Alignment.topRight,

                child: IconButton(
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
                ),
              )
            ]),
            backgroundColor: kPrimaryColor,
          ),
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
                                    onPressed: () => {},
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
                                      onPressed: () => {},
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
                                      onPressed: () => {},
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
    print("Here *** " + _miller_id.toString());
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);
    var res =
        await http.get(Uri.parse(EXTENSION_OFFICERS), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];

      //filter before returning data.
      List<dynamic> filteredData = data
          .where((e) => e["company"]["id"].toString() == _miller_id.toString())
          .toList();
      loading = false;
      print(filteredData[0]["contact_first_name"]);
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
}
