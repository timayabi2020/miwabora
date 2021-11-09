import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
            title: Text("About Miwa Bora",
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
                Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 5,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Text(
                            "Miwabora is a Mobile App as a tool for delivering Extension Services and Research findings for Sugar industry value chain players(Farmers, Millers and Traders) in sugarcane farming in Kenya.",
                            style: TextStyle(fontSize: 18),
                          ))
                    ]))
              ],
            ),
          )),
    ]);
  }
}
