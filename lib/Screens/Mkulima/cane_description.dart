import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CaneDescriptionPage extends StatelessWidget {
  final String? text;
  final String? url;
  final String? title;
  final bool? internetCheck;
  final List? locations;
  const CaneDescriptionPage(
      {Key? key,
      this.text,
      this.url,
      this.title,
      this.internetCheck,
      this.locations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(
          title.toString(),
          style: TextStyle(fontSize: 15),
        )),
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
                        "Variety Information",
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
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.06),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Growing Locations",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          SizedBox(height: size.height * 0.03),
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
                              itemCount: locations!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text(locations![index]["name"]),
                                    SizedBox(height: size.height * 0.08),
                                  ],
                                );
                              }),
                        ])))
          ],
        )));
  }
}
