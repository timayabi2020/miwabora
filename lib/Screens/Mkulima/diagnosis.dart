import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Network/network.dart';
import 'package:miwabora/Screens/Dashboard/dashboard.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/components/general_text.dart';
import 'package:miwabora/components/rounded_button.dart';
import 'package:miwabora/components/utility_text.dart';
import 'package:miwabora/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;
import 'dart:async';
import 'package:flutter/services.dart';

import 'extension_officers.dart';

class DIagnosisPage extends StatefulWidget {
  final String? imgPath;
  final Map<String, dynamic>? payload;
  final String? miller_id;

  const DIagnosisPage({Key? key, this.imgPath, this.payload, this.miller_id})
      : super(key: key);

  @override
  _DIagnosisPageState createState() =>
      _DIagnosisPageState(imgPath, payload, miller_id);
}

class _DIagnosisPageState extends State<DIagnosisPage> {
  String? _path;
  Map<String, dynamic>? _payload;
  List? _listResult;
  bool _loading = false;
  XFile? imageFile;
  bool? loading;
  String? _miller_id;
  List diseases = [];
  bool internetCheck = false;
  String resultMessage = "Please click on the classify button";
  _DIagnosisPageState(
      String? imgPath, Map<String, dynamic>? payload, String? millerid) {
    this._path = imgPath;
    this._payload = payload;
    this._miller_id = millerid;
  }
  @override
  void initState() {
    // TODO: implement initState
    networkCheck();
    _extractProfilePic();
    _loadModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "Disease Diagnosis",
          style: TextStyle(fontSize: 15),
        )),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: FileImage(File(imageFile!.path)),
                            fit: BoxFit.cover)))),
            RoundedButton(
              text: "CLASSIFY",
              color: kPrimaryColor,
              sizeval: 0.5,
              press: () {
                //  buildShowDialog(context);
                //logoutAlertDialog(context);
                _imageClasification();
              },
            ),
            _listResult == null || _listResult == 0
                ? Text(resultMessage)
                : Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 2,
                    child: Container(
                        child: Column(children: [
                      // Text(products[index]["name"]),
                      Row(children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              "Disease",
                              maxLines: 15,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              "Confidence",
                              maxLines: 15,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),

                      Row(children: [
                        Flexible(
                          child: Center(
                              child: GeneralTextComponent(
                            press: () {
                              showInfo(_listResult![0]["label"], context, size);
                            },
                            text: _listResult![0]["label"],
                          )),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              converter(_listResult![0]["confidence"]),
                              maxLines: 15,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      buildDivider(),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                              child: GeneralTextComponent(
                            press: () {
                              showInfo(_listResult![1]["label"], context, size);
                            },
                            text: _listResult![1]["label"],
                          )),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              converter(_listResult![1]["confidence"]),
                              maxLines: 15,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                      buildDivider(),
                      SizedBox(height: size.height * 0.03),
                      Row(children: [
                        Flexible(
                          child: Center(
                              child: GeneralTextComponent(
                            press: () {
                              showInfo(_listResult![2]["label"], context, size);
                            },
                            text: _listResult![2]["label"],
                          )),
                        ),
                        //const SizedBox(width: 8),
                        Flexible(
                          child: Center(
                            child: Text(
                              converter(_listResult![2]["confidence"]),
                              maxLines: 15,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: size.height * 0.03),
                    ]))),
            RoundedButton(
              text: "GO BACK",
              color: Colors.grey,
              sizeval: 0.9,
              press: () {
                //  buildShowDialog(context);
                //logoutAlertDialog(context);
                navigateToDashboard(context);
              },
            )
          ],
        )));
  }

  void _extractProfilePic() async {
    XFile preloaded = new XFile(this._path.toString());
    setState(() {
      imageFile = preloaded;
    });
  }

  void _loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    ).then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  void _imageClasification() async {
    // print(imageFile!.readAsBytes());
    /*var output = await Tflite.runModelOnImage(
        path: imageFile!.path.toString(),
        numResults: 3,
        threshold: 0.5,
        imageMean: 0.0,
        imageStd: 255.0,
        asynch: true);*/
    int startTime = new DateTime.now().millisecondsSinceEpoch;
    //var imageBytes = imageFile!.path.buffer;

    var imageBytes = await _readFileByte(imageFile!.path);
    File image =
        new File(imageFile!.path); // Or any other way to get a File instance.
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    //print(decodedImage.height);
    var recognitions = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(
          img.Image.fromBytes(50, 50, imageBytes!), 224, 127.5, 127.5),
      numResults: 9,
      threshold: 0.05,
    );
    setState(() {
      _listResult = recognitions;
    });
    int endTime = new DateTime.now().millisecondsSinceEpoch;
    print("Inference took ${endTime - startTime}ms");
    print(recognitions);
    /*setState(() {
      _loading = false;
      _listResult = output;
    });*/
    //print("My bytes" + imageBytes.toString());
  }

  Future<Uint8List?> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    Uint8List? bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      //print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    try {
      var buffer = Float32List.view(convertedBytes.buffer);
      int pixelIndex = 0;
      for (var i = 0; i < inputSize; i++) {
        for (var j = 0; j < inputSize; j++) {
          var pixel = image.getPixel(j, i);
          buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
          buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
          buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
        }
      }
    } catch (e) {
      setState(() {
        resultMessage =
            "Unable to classigy the requested image. Please try another one";
      });
    }
    return convertedBytes.buffer.asUint8List();
  }

  buildDivider() {
    return Divider(
      color: Colors.black,
      height: 10,
      thickness: 1.5,
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  String converter(param0) {
    String val = param0.toString();
    var longVal = double.parse(val);
    print(longVal);
    return (longVal * 100).toDouble().toStringAsFixed(2) + "%";
  }

  void navigateToDashboard(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (BuildContext context) => Dashboard(_payload!)),
      (route) => false,
    );
  }

  void showInfo(String name, BuildContext context, Size size) async {
    List<dynamic> filteredData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loading = true;
    try {
      if (prefs.getString("diseases") == null) {
        final ioc = new HttpClient();
        ioc.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        final http = new IOClient(ioc);
        var res = await http.get(Uri.parse(DISEASE), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': 'AppBearer ' + token,
        });
        if (res.statusCode == 200) {
          //var obj = json.decode(res.body);
          Map<String, dynamic> map = json.decode(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("diseases", res.body);
          List<dynamic> data = map["data"];
          filteredData = data
              .where((e) =>
                  e["sugarcane_diseases_name"].toString().toUpperCase() ==
                  name.toUpperCase())
              .toList();

          setState(() {
            diseases = filteredData;
          });

          loading = false;
        }
      } else {
        setState(() {
          loading = true;
        });
        String storedData = prefs.getString("diseases").toString();
        Map<String, dynamic> map = json.decode(storedData);
        List<dynamic> data = map["data"];

        //filter before returning data.
        filteredData = data
            .where((e) => e["sugarcane_diseases_name"]
                .toString()
                .trim()
                .contains(name.toUpperCase().trim()))
            .toList();

        setState(() {
          diseases = filteredData;
        });
        setState(() {
          loading = false;
        });
        print(filteredData[0]['disease_picture']['url']);
        diseasesOptions(context, size, name);
      }
    } catch (e) {
      loading = false;
    }
  }

  void diseasesOptions(BuildContext context, Size size, String diseaseName) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    UtilityText(
                      press: () {
                        navigateToOfficers(context);
                      },
                      text: 'GET HELP',
                    ),
                    SizedBox(width: size.width * 0.2),
                    ResetPassword(
                      press: () {
                        Navigator.of(context).pop();
                      },
                      text: 'CANCEL',
                    )
                  ],
                )
              ],
              content: SingleChildScrollView(
                  child: Column(children: [
                Container(
                    child: internetCheck == false
                        ? Image.asset(
                            "assets/images/logobora.png",
                            width: 250,
                          )
                        : Image.network(
                            diseases[0]['disease_picture']['url'],
                            width: size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          )),
                Text(
                  diseaseName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Card(
                    color: Colors.white,
                    // color: Color.fromRGBO(138, 170, 243, 0.5),

                    elevation: 2,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Symptoms",
                            style: TextStyle(color: Colors.redAccent),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: Html(data: diseases[0]['symptoms'].toString()))
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
                          child:
                              Html(data: diseases[0]['management'].toString()))
                    ])),
              ])));
        });
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

  void navigateToOfficers(BuildContext context) {
    //print("=====> " + _miller_id.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OfficersPage(_miller_id.toString());
        },
      ),
    );
  }
}
