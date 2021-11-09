import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Network/network.dart';
import 'package:miwabora/Screens/Mkulima/common_description.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestPage extends StatefulWidget {
  const InvestPage({Key? key}) : super(key: key);

  @override
  _InvestPage createState() => _InvestPage();
}

class _InvestPage extends State<InvestPage> {
  List establishment = [];
  List searchList = [];
  bool loading = true;
  bool internetCheck = false;
  @override
  void initState() {
    getData().then((data) {
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
          .where((s) =>
              s["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
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
            title: Row(children: [
              Flexible(
                child: Text("Investment Opportunities",
                    maxLines: 15,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ]),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  //size: 40,
                ),
                color: Colors.white,
                onPressed: () => {
                  if (this.internetCheck == false)
                    {showNetworkError(context)}
                  else
                    {
                      fetchFarmings().then((data) {
                        setState(() {
                          establishment = data;
                        });
                      })
                    }
                },
              )
            ]),
        // backgroundColor: kPrimaryColor,
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
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.05),
                                  child: internetCheck == false
                                      ? Image.asset(
                                          "assets/images/ic_farm_demo_foreground.png",
                                          width: 100,
                                        )
                                      : Image.network(
                                          "${searchList[index]['photo']['url']}",
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
                                            "${searchList[index]['name']}",
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

  Future fetchFarmings() async {
    loading = true;
    List<dynamic> filteredData = [];
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      var res =
          await http.get(Uri.parse(VALUEADDITION), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'AppBearer ' + token,
      });
      if (res.statusCode == 200) {
        //var obj = json.decode(res.body);
        Map<String, dynamic> map = json.decode(res.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("investment", res.body);
        List<dynamic> data = map["data"];

        //filter before returning data.
        List<dynamic> filteredData =
            data.where((e) => e["category"] == "InvestinMilling").toList();
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

    if (prefs.getString("investment") == null) {
      fetchFarmings().then((data) {
        setState(() {
          establishment = data;
        });
      });
    } else {
      setState(() {
        loading = true;
      });
      String storedData = prefs.getString("investment").toString();
      Map<String, dynamic> map = json.decode(storedData);
      List<dynamic> data = map["data"];

      //filter before returning data.
      filteredData = data
          .where((e) => e["category"].toString() == "InvestinMilling")
          .toList();
      setState(() {
        loading = false;
      });
    }
    return filteredData;
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
            internetCheck: this.internetCheck,
          );
        },
      ),
    );
  }
}
