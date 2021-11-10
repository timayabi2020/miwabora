import 'dart:async';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:miwabora/constants.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatefulWidget {
  final String? url;
  final String? title;
  final String? filename;
  const PdfViewer({Key? key, this.url, this.title, this.filename})
      : super(key: key);

  @override
  _PdfViewerState createState() => _PdfViewerState(url, title, filename);
}

class _PdfViewerState extends State<PdfViewer> {
  String? _url;
  String? _title;
  String? _filename;

  _PdfViewerState(String? url, String? title, String? filename) {
    this._url = url;
    this._title = title;
    this._filename = filename;
  }
  bool _isLoading = true;
  bool _isDocFound = true;
  bool? _isdownloading = false;
  bool? success = false;
  PDFDocument? document;

  @override
  void initState() {
    // TODO: implement initState
    loadDocument();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Flexible(
                child: Text(
              _title.toString(),
              maxLines: 20,
              style: TextStyle(fontSize: 15),
            ))
          ]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                downloadFile(_url.toString(), _filename.toString(), "miwabora");
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                success! ? loadDocument() : null;
              },
            ),
          ],
        ),
        body: Stack(children: [
          Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _isDocFound
                    ? PDFViewer(
                        document: document!,
                        zoomSteps: 1,
                        //uncomment below line to preload all pages
                        // lazyLoad: false,
                        // uncomment below line to scroll vertically
                        // scrollDirection: Axis.vertical,

                        //uncomment below code to replace bottom navigation with your own
                        /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
                      )
                    : Text("Failed to retrieve the requested document!"),
          ),
          Center(
              child: Visibility(
            visible: _isdownloading!,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)),
          ))
        ]));
  }

  void loadDocument() async {
    print("My url " + _url.toString());
    setState(() => _isLoading = true);
    try {
      document = await PDFDocument.fromURL(
        _url.toString(),
        /* cacheManager: CacheManager(
          Config(
            "customCacheKey",
            stalePeriod: const Duration(days: 2),
            maxNrOfCacheObjects: 10,
          ),
        ), */
      );

      setState(() => _isLoading = false);
      setState(() => success = true);
    } catch (e) {
      print(e);
      setState(() => _isLoading = false);
      setState(() => _isDocFound = false);
    }
  }

  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';
    setState(() => _isdownloading = true);
    try {
      myUrl = url;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      } else
        filePath = 'Error code: ' + response.statusCode.toString();
      setState(() => _isdownloading = false);
    } catch (ex) {
      filePath = 'Can not fetch url';
      setState(() => _isdownloading = false);
    }
    setState(() => _isdownloading = false);
    return filePath;
  }
}
