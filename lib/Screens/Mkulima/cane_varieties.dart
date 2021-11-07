import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/constants.dart';

class CaneVarietyPage extends StatefulWidget {
  const CaneVarietyPage({Key? key}) : super(key: key);

  @override
  _CaneVarietyPage createState() => _CaneVarietyPage();
}

class _CaneVarietyPage extends State<CaneVarietyPage> {
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

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = establishment;
    } else {
      results = establishment
          .where((s) =>
              s["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
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
              child: Text("Recommended Commercial Sugarcane Varieties",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )),
            SizedBox(width: size.width * 0.03),
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
                                  child: Image.network(
                                    "${establishment[index]['photo']['url']}",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      "${establishment[index]['name']}",
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
    var res = await http.get(Uri.parse(CANE_VARIETY), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];

      //filter before returning data.
      List<dynamic> filteredData =
          data.where((e) => e["photo"] != null).toList();
      loading = false;
      return filteredData;
    }
  }

  void moreDetails(int index, BuildContext context) {
    String description = establishment[index]["description"];
    String title = establishment[index]["name"];
    String imgUrl = establishment[index]['photo']['url'];

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