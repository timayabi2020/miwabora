import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/Millers/product_description.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/Screens/Mkulima/common_disease_description.dart';
import 'package:miwabora/Screens/News/prices_description.dart';
import 'package:miwabora/constants.dart';

class ProductionPage extends StatefulWidget {
  const ProductionPage({Key? key}) : super(key: key);

  @override
  _ProductionPage createState() => _ProductionPage();
}

class _ProductionPage extends State<ProductionPage> {
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
          .where((s) => s["project"]["note_text"]
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
              child: Text("Cost of production",
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
                                      "assets/images/Labour-rates-per-zone.png",
                                      width: 100,
                                    )),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text('',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Text(
                                        "Zone ${searchList[index]['note_text']}",
                                        maxLines: 20,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Text(
                                        "Activity: ${searchList[index]['activity']}",
                                        maxLines: 20,
                                      )),
                                    ]),
                                  ],
                                )),
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
        await http.get(Uri.parse(PRODUCTION_COST), headers: <String, String>{
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
    String title = establishment[index]["note_text"];
    print("Title " + title);
    String activity = establishment[index]["activity"];
    String unit = establishment[index]["unit"];
    String quantity = establishment[index]["quantity"].toString();
    String unit_cost = establishment[index]["unit_cost"];
    String plant_crop = establishment[index]["plant_crop"];
    String ratoon_crop = establishment[index]["ratoon_crop"];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProductionDescriptionPage(
            activity: activity == null ? "" : activity,
            unit: unit == null ? "" : unit,
            quantity: quantity == null ? "" : quantity,
            unit_cost: unit_cost == null ? "" : unit_cost,
            plant_crop: plant_crop == null ? "" : plant_crop,
            ratoon_crop: ratoon_crop == null ? "" : ratoon_crop,
            title: title,
          );
        },
      ),
    );
  }
}