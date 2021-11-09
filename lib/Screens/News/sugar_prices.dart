import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/Screens/Mkulima/common_disease_description.dart';
import 'package:miwabora/Screens/News/prices_description.dart';
import 'package:miwabora/constants.dart';

class SugarCanePricesPage extends StatefulWidget {
  const SugarCanePricesPage({Key? key}) : super(key: key);

  @override
  _SugarCanePricesPage createState() => _SugarCanePricesPage();
}

class _SugarCanePricesPage extends State<SugarCanePricesPage> {
  List establishment = [];
  List searchList = [];
  bool loading = true;
  @override
  void initState() {
    fetchFarmings().then((data) {
      setState(() {
        establishment = data;
        searchList = data;
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
          .where((s) => s["project"]["name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      searchList = results;
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
              child: Text("Sugar cane prices",
                  maxLines: 15,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            )),
            SizedBox(width: size.width * 0.2),
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
                TextField(
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                      labelText: 'Search here...',
                      suffixIcon: Icon(Icons.search)),
                ),
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
                    itemCount: searchList.length,
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
                                    padding: EdgeInsets.only(
                                        left: size.width * 0.05),
                                    child: Image.asset(
                                      "assets/images/Sugarcane-prices.png",
                                      width: 100,
                                    )),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Container(
                                    child: establishment.length == 0
                                        ? Text("Loading data...")
                                        : Text(
                                            "Brand: ${searchList[index]["project"]["name"]}",
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
    var res =
        await http.get(Uri.parse(SUGARCANEPRICES), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      //'Authorization': 'AppBearer ' + token,
    });
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      List<dynamic> data = map["data"];

      //filter before returning data.
      loading = false;
      return data;
    }
  }

  void moreDetails(int index, BuildContext context) {
    String description = establishment[index]["symproms"];
    String title = establishment[index]["project"]["name"];

    String twenty_five_bag = establishment[index]["twenty_five_kg_bag"];
    String twenty_five_bale = establishment[index]["twenty_five_kg_bale"];
    String twenty_four_bale = establishment[index]["twenty_four_kg_bale"];
    String twenty_bale = establishment[index]["twenty_kg_bale"];
    String eighteen_bale = establishment[index]["eighteen_kg_bale"];
    String fifteen_bale = establishment[index]["fifteen_kg_bale"];
    String twelve_bale = establishment[index]["twelve_kg_bale"];
    String ten_bale = establishment[index]["ten_kg_bale"];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PricesescriptionPage(
            twenty_five_bag: twenty_five_bag == null ? "" : twenty_five_bag,
            twenty_five_bale: twenty_five_bale == null ? "" : twenty_five_bale,
            twenty_four_bale: twenty_four_bale == null ? "" : twenty_four_bale,
            twelve_bale: twelve_bale == null ? "" : twelve_bale,
            eighteen_bale: eighteen_bale == null ? "" : eighteen_bale,
            fifteen_bale: fifteen_bale == null ? "" : fifteen_bale,
            twenty_bale: twenty_bale == null ? "" : twenty_bale,
            ten_bale: ten_bale == null ? "" : ten_bale,
            title: title,
          );
        },
      ),
    );
  }
}
