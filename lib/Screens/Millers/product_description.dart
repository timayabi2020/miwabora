import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductionDescriptionPage extends StatelessWidget {
  final String? activity;
  final String? unit;
  final String? quantity;
  final String? unit_cost;
  final String? plant_crop;
  final String? ratoon_crop;
  final String? title;
  final bool? internetCheck;
  const ProductionDescriptionPage(
      {Key? key,
      this.activity,
      this.unit,
      this.quantity,
      this.unit_cost,
      this.plant_crop,
      this.ratoon_crop,
      this.title,
      this.internetCheck})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text(title.toString() + " Details")),
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
                        title.toString(),
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
                            DataCell(Text('Activty:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.activity.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Unit:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.unit.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Quantity',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.quantity.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Unit cost:',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.unit_cost.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Plant crop',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.plant_crop.toString(),
                              style: TextStyle(color: Colors.redAccent),
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ratoon crop',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(
                              this.ratoon_crop.toString(),
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
