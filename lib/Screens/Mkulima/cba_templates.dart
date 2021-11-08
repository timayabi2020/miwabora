import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/constants.dart';

class CBATemplatePage extends StatefulWidget {
  const CBATemplatePage({Key? key}) : super(key: key);

  @override
  _CBATemplatePageState createState() => _CBATemplatePageState();
}

class _CBATemplatePageState extends State<CBATemplatePage> {
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
          title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                //padding: EdgeInsets.only(left: size.width * 0.05),
                //alignment: Alignment.centerLeft,
                child: Flexible(
              child: Text("Farm Record Templates",
                  maxLines: 20,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )),
            //SizedBox(width: size.width * 0.03),
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
          child: Row(children: [
            Expanded(
                child: Container(
                    child: Column(
              children: <Widget>[
                ListView.builder(
                    /*gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 6),
                          ),*/
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: establishment.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            // doPayment(position, context);
                            moreDetails(index, context);
                          },
                          child: Card(
                              color: Colors.white,
                              // color: Color.fromRGBO(138, 170, 243, 0.5),

                              elevation: 2,
                              child: Container(
                                  child: Row(children: [
                                Container(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: establishment.length == 0
                                      ? Image.asset(
                                          "assets/images/ic_farm_demo_foreground",
                                          width: 250,
                                        )
                                      : Image.network(
                                          "${establishment[index]['snapshot']['url']}",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    child: establishment.length == 0
                                        ? Text("Loading data...")
                                        : Text(
                                            "${establishment[index]['title']}",
                                            maxLines: 15,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
                              ]))));
                    })
              ],
            )))
          ]),
        ),
      ),
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
    var res = await http.get(Uri.parse(PUBLICATIONS), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];

      //filter before returning data.
      List<dynamic> filteredData =
          data.where((e) => e["type"].toString() == "farm").toList();
      loading = false;
      return filteredData;
    }
  }

  void moreDetails(int index, BuildContext context) {
    String description = establishment[index]["overview"];
    String title = establishment[index]["title"];
    String imgUrl = establishment[index]['snapshot']['url'];
    String fileName = ROOT + "/" + establishment[index]["file"]["filename"];

    /*Navigator.push(
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
    );*/
  }
}
