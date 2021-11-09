import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PricesescriptionPage extends StatelessWidget {
  final String? twenty_five_bale;
  final String? twenty_five_bag;
  final String? twenty_four_bale;
  final String? twenty_bale;
  final String? eighteen_bale;
  final String? fifteen_bale;
  final String? twelve_bale;
  final String? ten_bale;
  final String? title;
  const PricesescriptionPage(
      {Key? key,
      this.twenty_five_bale,
      this.twenty_five_bag,
      this.twenty_four_bale,
      this.twenty_bale,
      this.eighteen_bale,
      this.fifteen_bale,
      this.twelve_bale,
      this.ten_bale,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text(title.toString() + " Prices")),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                color: Colors.white,
                // color: Color.fromRGBO(138, 170, 243, 0.5),

                elevation: 2,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      alignment: Alignment.topLeft,
                      child: Text(
                        title.toString() + " Brand",
                        style: TextStyle(color: Colors.redAccent),
                      )),
                  Container(
                      padding: EdgeInsets.only(left: size.width * 0.05),
                      child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text('',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('25Kg (Bag):',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.twenty_five_bag.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('25Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.twenty_five_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('24Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.twenty_four_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('20Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.twenty_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('18Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.eighteen_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('15Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.fifteen_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('12Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.twelve_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('10Kg (Bale)',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              "KES. " + this.ten_bale.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                        ],
                      )),
                ]))
          ],
        )));
  }
}
