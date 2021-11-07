import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MkulimaDescriptionPage extends StatelessWidget {
  final String? text;
  final String? url;
  final String? title;
  const MkulimaDescriptionPage({Key? key, this.text, this.url, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text(title.toString())),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(child: Image.network(url.toString(), width: size.width)),
            Card(
                color: Colors.white,
                // color: Color.fromRGBO(138, 170, 243, 0.5),

                elevation: 2,
                child: Html(data: text))
          ],
        )));
  }
}
