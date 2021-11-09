import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MkulimaDiseaseDescriptionPage extends StatelessWidget {
  final String? text;
  final String? url;
  final String? title;
  final String? management;
  final bool? internetCheck;
  const MkulimaDiseaseDescriptionPage(
      {Key? key,
      this.text,
      this.url,
      this.title,
      this.management,
      this.internetCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Flexible(
                child: Text(
          title.toString(),
          style: TextStyle(fontSize: 15),
          maxLines: 20,
        ))),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                child: internetCheck == false
                    ? Image.asset(
                        "assets/images/logobora.png",
                        width: 250,
                      )
                    : Image.network(
                        url.toString(),
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
                      child: Html(data: text))
                ])),
            Card(
                color: Colors.white,
                // color: Color.fromRGBO(138, 170, 243, 0.5),

                elevation: 2,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Management",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                  Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: Html(data: management))
                ]))
          ],
        )));
  }
}
