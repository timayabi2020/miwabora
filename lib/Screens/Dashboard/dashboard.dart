import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:miwabora/Config/config.dart';
import 'package:miwabora/Screens/About/about.dart';
import 'package:miwabora/Screens/Feedback/complaints.dart';
import 'package:miwabora/Screens/Feedback/questions.dart';
import 'package:miwabora/Screens/Help/help.dart';
import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/Screens/Millers/investment.dart';
import 'package:miwabora/Screens/Millers/production_cost.dart';
import 'package:miwabora/Screens/Mkulima/cane_varieties.dart';
import 'package:miwabora/Screens/Mkulima/cba.dart';
import 'package:miwabora/Screens/Mkulima/cba_templates.dart';
import 'package:miwabora/Screens/Mkulima/crop_management.dart';
import 'package:miwabora/Screens/Mkulima/diseases.dart';
import 'package:miwabora/Screens/Mkulima/extension_officers.dart';
import 'package:miwabora/Screens/Mkulima/gettingstarted.dart';
import 'package:miwabora/Screens/Mkulima/harvesting.dart';
import 'package:miwabora/Screens/Mkulima/innovation.dart';
import 'package:miwabora/Screens/Mkulima/pests.dart';
import 'package:miwabora/Screens/Mkulima/production_environment.dart';
import 'package:miwabora/Screens/Mkulima/sugar_cane_establishment.dart';
import 'package:miwabora/Screens/Mkulima/weeds.dart';
import 'package:miwabora/Screens/News/industry_news.dart';
import 'package:miwabora/Screens/News/newsletter.dart';
import 'package:miwabora/Screens/News/sugar_prices.dart';
import 'package:miwabora/Screens/News/sugarcabnebrands.dart';
import 'package:miwabora/Screens/News/tech.dart';
import 'package:miwabora/Screens/News/value_addition.dart';
import 'package:miwabora/Screens/Profile/profile_breif.dart';
import 'package:miwabora/components/forgot_password.dart';
import 'package:miwabora/constants.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Map<String, dynamic>? resultsMap;
  Dashboard(Map<String, dynamic> details) {
    this.resultsMap = details;
  }

  @override
  _DashboardState createState() => _DashboardState(resultsMap);
}

class _DashboardState extends State<Dashboard> {
  Map<String, dynamic>? details;
  String? _username;
  String? _phone;
  String? _email;
  String? _userId;
  String? _role;
  String? _miller_id;
  _DashboardState(Map<String, dynamic>? resultsMap) {
    this.details = resultsMap;
  }

  @override
  void initState() {
    _extractDetails();
    //
  }

  void _extractDetails() {
    String? username = this.details!["username"];
    String? userId = this.details!["userid"];
    String? phone = this.details!["phone"];
    String? email = this.details!["email"];
    String? role = this.details!["role"];

    setState(() {
      _username = username;
      _email = email;
      _phone = phone;
      _userId = userId;
      _role = role;
    });

    if (role == "Farmer") {
      String? miller = this.details!["miller_id"];
      print("Here setting miller id " + miller.toString());
      setState(() {
        _miller_id = miller;
      });
    }
  }

  List mkulimaList = [
    _MkulimaItem('assets/images/ic_mkulima_mkulima.png', 'Getting Started'),
    _MkulimaItem(
        'assets/images/ic_tech_foreground.png', 'Production Environment'),
    _MkulimaItem('assets/images/establishment.png', 'Sugarcane Establishment'),
    _MkulimaItem('assets/images/ic_cane_varieties_foreground.png',
        'Sugarcane Varieties'),
    _MkulimaItem(
        'assets/images/ic_seed_cane_foreground.png', 'Crop Management'),
    _MkulimaItem(
        'assets/images/ic_pest_foreground.png', 'Diseases,Pests & Weeds'),
    _MkulimaItem(
        'assets/images/ic_farm_demo_foreground.png', 'Harvesting & Transport'),
    _MkulimaItem('assets/images/ic_tech_foreground.png',
        'Extension & Innovation Promotion'),
    _MkulimaItem('assets/images/Yearbooks.png', 'Farm Records & C.B.A'),
    _MkulimaItem('assets/images/extension-officer.png', 'Extension Officers'),
  ];

  List newsList = [
    _NewsItem('assets/images/ic_bulletin_foreground.png', 'Industry News'),
    _NewsItem('assets/images/ic_news_letter_foreground.png', 'Newsletter'),
    _NewsItem(
        'assets/images/ic_sugar_brand_foreground.png', 'Local Sugar Brands'),
    _NewsItem('assets/images/Sugarcane-prices.png', 'Sugar Prices'),
  ];

  List millerList = [
    _MillerItem(
        'assets/images/Value-Addition.png', 'Value Addition Opportunities'),
    _MillerItem(
        'assets/images/ic_tech_foreground.png', 'Technology & Innovations'),
    _MillerItem(
        'assets/images/Labour-rates-per-zone.png', 'Cost of Production'),
    _MillerItem(
        'assets/images/Invest-in-Milling.png', 'Investment Opportunities'),
  ];

  List feedbackList = [
    _FeedbackItem('assets/images/ic_qns_foreground.png', 'Ask a question'),
    _FeedbackItem('assets/images/Raise-a-complain.png', 'Raise a Complaint'),
  ];

  List diseaseList = [
    _DiseaseItem('assets/images/ic_pest_foreground.png', 'Diseases'),
    _DiseaseItem('assets/images/ic_pest_foreground.png', 'Pests'),
    _DiseaseItem('assets/images/ic_pest_foreground.png', 'Weeds'),
    _DiseaseItem('assets/images/ic_cam_cam.png', 'Disease Diagnosis'),
  ];

  List farmList = [
    _FarmItem('assets/images/ic_year_foreground.png', 'Farm Records & C.B.A'),
    _FarmItem('assets/images/ic_year_foreground.png',
        'Farm Records & C.B.A Templates'),
  ];

  shareSocialMedia(BuildContext context, TargetPlatform platform) {
    String text = PLAYSTORELINK;
    if (platform == TargetPlatform.iOS) {
      text = APPSTORELINK;
    }
    RenderBox box = context.findRenderObject()! as RenderBox;

    // final RenderBox box =context.findRenderObject() as RenderObject;
    Share.share(text,
        subject: "Miwa Bora",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var platform = Theme.of(context).platform;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    child: Text(
                  "MKULIMA",
                  style: TextStyle(fontSize: 12),
                )),
                Tab(child: Text("NEWS", style: TextStyle(fontSize: 11))),
                Tab(child: Text("MILLER", style: TextStyle(fontSize: 11))),
                Tab(child: Text("FEEDBACK", style: TextStyle(fontSize: 11))),
              ],
            ),
            title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Container(
                //padding: EdgeInsets.only(left: size.width * 0.05),
                //alignment: Alignment.centerLeft,
                child: Text("Miwa Bora",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: size.width * 0.3),
              Container(
                // padding: EdgeInsets.only(left: size.width * 0.20),
                // alignment: Alignment.topRight,

                child: IconButton(
                  icon: Icon(
                    Icons.lock_open,
                    //size: 40,
                  ),
                  color: Colors.white,
                  onPressed: () => logoutAlertDialog(context),
                ),
              )
            ]),
          ),
          drawer: Drawer(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[
            DrawerHeader(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {},
                      //child: Text('Button'),
                      style: OutlinedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(40),
                        backgroundColor: kPrimaryColor,
                        side: BorderSide(color: kPrimaryColor, width: 1),
                      ),
                      child: Text(
                        _username!.characters
                            .characterAt(0)
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      this._username.toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(this._email!),
                  ]),
            ),
            //buildDivider(),
            ListTile(
              title: Text('Home'),
              leading: new IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    //_displayDialog(context);
                  }),
              onTap: () {
                //_displayDialog(context);
              },
            ),
            ListTile(
              title: Text('About'),
              leading: new IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    navigateToAbout(context);
                  }),
              onTap: () {
                navigateToAbout(context);
              },
            ),
            ListTile(
              title: Text('Help'),
              leading: new IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    navigateToHelp(context);
                  }),
              onTap: () {
                navigateToHelp(context);
              },
            ),
            ListTile(
              title: Text('Share'),
              leading: new IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    shareSocialMedia(context, platform);
                  }),
              onTap: () {
                //_displayDialog(context);
                shareSocialMedia(context, platform);
              },
            ),
            buildDivider(),
            Container(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Text("Disease Diagnosis",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)))),
            ListTile(
              title: Text('Use Camera'),
              leading: new IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () {
                    //_displayDialog(context);
                  }),
              onTap: () {
                //_displayDialog(context);
              },
            ),
            ListTile(
              title: Text('Open Gallery'),
              leading: new IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () {
                    //_displayDialog(context);
                  }),
              onTap: () {
                //_displayDialog(context);
              },
            ),
            buildDivider(),
            Container(
                padding: EdgeInsets.only(left: size.width * 0.05),
                child: Text("Account",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)))),
            ListTile(
              title: Text('Profile'),
              leading: new IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    navigateToProfile(context);
                  }),
              onTap: () {
                navigateToProfile(context);
              },
            ),
            ListTile(
              title: Text('Logout'),
              leading: new IconButton(
                  icon: Icon(Icons.lock),
                  onPressed: () {
                    logoutAlertDialog(context);
                  }),
              onTap: () {
                logoutAlertDialog(context);
              },
            ),
          ])),
          body: TabBarView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        // doPayment(position, context);
                        openMkulimaServices(position, context, size);
                      },
                      child: Card(
                        semanticContainer: true,
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              mkulimaList[position].icon.toString(),
                              height: 100,
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text(mkulimaList[position].title,
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                      onPressed: () {
                                        openMkulimaServices(
                                            position, context, size);
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: mkulimaList.length,
                ),
              ),

              //Starting news menu
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        openNewsServices(position, context, size);
                      },
                      child: Card(
                        semanticContainer: true,
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              newsList[position].icon.toString(),
                              height: 100,
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text(newsList[position].title,
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                      onPressed: () {
                                        // openServices(
                                        openNewsServices(
                                            position, context, size);
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: newsList.length,
                ),
              ),

              //starting miller
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        // doPayment(position, context);
                        openMillerServices(position, context, size);
                      },
                      child: Card(
                        semanticContainer: true,
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              millerList[position].icon.toString(),
                              height: 100,
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text(millerList[position].title,
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                      onPressed: () {
                                        openMillerServices(
                                            position, context, size);
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: millerList.length,
                ),
              ),
              //Starting feedback menus
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        fedbackTap(context, position);
                      },
                      child: Card(
                        semanticContainer: true,
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              feedbackList[position].icon.toString(),
                              height: 100,
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    TextButton(
                                      child: Text(feedbackList[position].title,
                                          style:
                                              TextStyle(color: kPrimaryColor)),
                                      onPressed: () {
                                        fedbackTap(context, position);
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: feedbackList.length,
                ),
              ),
            ],
          ),
        ));
  }

  //for raising complaints and asking questions
  void fedbackTap(BuildContext context, int position) {
    print(position);
    if (position == 0) {
      //navigate to questions
      navigateToQuestions(context);
    } else {
      //navigate to complaints
      navigateToComplaints(context);
    }
  }

  void navigateToQuestions(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return QuestionsPage(
              this._userId!, this._username!, this._email!, this.details!);
        },
      ),
    );
  }

  void navigateToComplaints(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ComplaintsPage(
              this._userId!, this._username!, this._email!, this.details!);
        },
      ),
    );
  }

  logoutAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "CANCEL",
        style: TextStyle(color: kPrimaryColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("LOGOUT", style: TextStyle(color: kPrimaryColor)),
      onPressed: () {
        navigateToLogin(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Alert!",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      content: Text("Are you sure you want to logout?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void navigateToLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("logged_in", false);
    prefs.remove("profile_data");
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
      (route) => false,
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProfileBrief(details!);
        },
      ),
    );
  }

  buildDivider() {
    return Divider(
      color: Colors.black,
      height: 10,
      thickness: 1.5,
    );
  }

  void openServices(int position, BuildContext context) {
    print(position);
  }

  void openMkulimaServices(int position, BuildContext context, Size size) {
    print(position);
    if (position == 0) {
      navigateToBeginner(context);
    } else if (position == 1) {
      navigateToproductionEnvironment(context);
    } else if (position == 2) {
      navigateToSugarcaneEstablishment(context);
    } else if (position == 3) {
      navigateToCaneVariety(context);
    } else if (position == 4) {
      navigateToCropManagement(context);
    } else if (position == 5) {
      diseasesOptions(context, size);
    } else if (position == 6) {
      navigateToHarvesting(context);
    } else if (position == 7) {
      navigateToInnovation(context);
    } else if (position == 8) {
      farmRecordsOptions(context, size);
    } else if (position == 9) {
      navigateToOfficers(context);
    }
  }

  void navigateToSugarcaneEstablishment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SugarcaneEstablishmentPage();
        },
      ),
    );
  }

  void navigateToproductionEnvironment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProductionEnvironmentPage();
        },
      ),
    );
  }

  void navigateToAbout(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return About();
        },
      ),
    );
  }

  void navigateToCaneVariety(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CaneVarietyPage();
        },
      ),
    );
  }

  void navigateToCropManagement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CropManagementPage();
        },
      ),
    );
  }

  void navigateToHarvesting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HarvestingPage();
        },
      ),
    );
  }

  void navigateToInnovation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InnovationPage();
        },
      ),
    );
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

  void navigateToBeginner(BuildContext context) {
    //print("=====> " + _miller_id.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return GettingStartedPage();
        },
      ),
    );
  }

  /*void farmRecordsOptions(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Select below"),
            content: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                          // alignment: Alignment.center,
                          width: 115,
                          child: Card(
                              semanticContainer: true,
                              child: Column(children: [
                                Image.asset(
                                  "assets/images/ic_year_foreground.png",
                                  width: 150,
                                ),
                                TextButton(
                                  onPressed: () {
                                    this.goToCBA(context);
                                  },
                                  // onTap: press,
                                  //  child: Container(
                                  child: Text(
                                    "Farm Records & C.B.A",
                                    maxLines: 20,
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                )
                              ]))),
                      Container(
                        width: 115,
                        child: Card(
                            child: Column(children: [
                          Image.asset(
                            "assets/images/ic_year_foreground.png",
                            width: 150,
                          ),
                          TextButton(
                            onPressed: () {
                              this.goToTemplates(context);
                            },
                            // onTap: press,
                            //child: Container(
                            child: Text(
                              "Farm Records & C.B.A Templates",
                              maxLines: 20,
                              style: TextStyle(
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        ])),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.05),
                  Row(
                    children: [
                      ResetPassword(
                        press: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Cancel',
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }*/

  void diseasesOptions(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text("Select below"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  //width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  //padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return GestureDetector(
                          onTap: () {
                            diseaseTap(context, position);
                          },
                          child: Container(
                            height: 100,
                            child: Card(
                              semanticContainer: true,
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    diseaseList[position].icon.toString(),
                                    height: 50,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        children: [
                                          TextButton(
                                            child: Text(
                                                diseaseList[position].title,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 11)),
                                            onPressed: () {
                                              diseaseTap(context, position);
                                            },
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ));
                    },
                    itemCount: diseaseList.length,
                  ),
                ),
                ResetPassword(
                  press: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Cancel',
                )
              ]));
        });
  }

  void farmRecordsOptions(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              title: Text("Select below"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  //width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  //padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return GestureDetector(
                          onTap: () {
                            farmTap(context, position);
                          },
                          child: Container(
                            height: 400,
                            child: Card(
                              // semanticContainer: true,
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    farmList[position].icon.toString(),
                                    height: 50,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        children: [
                                          TextButton(
                                            child: Text(
                                                farmList[position].title,
                                                style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 11)),
                                            onPressed: () {
                                              farmTap(context, position);
                                            },
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ));
                    },
                    itemCount: farmList.length,
                  ),
                ),
                ResetPassword(
                  press: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Cancel',
                )
              ]));
        });
  }

  goToTemplates(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CBATemplatePage();
        },
      ),
    );
  }

  goToCBA(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CBAPage();
        },
      ),
    );
  }

  void diseaseTap(BuildContext context, int position) {
    if (position == 0) {
      navigateToDisease(context);
    } else if (position == 1) {
      navigateToPests(context);
    } else if (position == 2) {
      navigateToWeeds(context);
    } else {}
  }

  void navigateToDisease(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DiseasesPage();
        },
      ),
    );
  }

  void navigateToWeeds(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeedsPage();
        },
      ),
    );
  }

  void navigateToBrands(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BrandsPage();
        },
      ),
    );
  }

  void navigateToPrices(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return SugarCanePricesPage();
        },
      ),
    );
  }

  void navigateToIndustryNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return IndustryNewsPage();
        },
      ),
    );
  }

  void navigateToNews(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NewsPage();
        },
      ),
    );
  }

  void navigateToPests(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PestsPage();
        },
      ),
    );
  }

  void openNewsServices(int position, BuildContext context, Size size) {
    if (position == 0) {
      navigateToIndustryNews(context);
    } else if (position == 1) {
      navigateToNews(context);
    } else if (position == 2) {
      navigateToBrands(context);
    } else if (position == 3) {
      navigateToPrices(context);
    }
  }

  void openMillerServices(int position, BuildContext context, Size size) {
    if (position == 0) {
      navigateToOpportunities(context);
    } else if (position == 1) {
      navigateToTech(context);
    } else if (position == 2) {
      navigateToProductionCost(context);
    } else if (position == 3) {
      navigateToInvestmentOpportunities(context);
    }
  }

  void navigateToOpportunities(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ValueAdditionPage();
        },
      ),
    );
  }

  void navigateToProductionCost(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ProductionPage();
        },
      ),
    );
  }

  void navigateToTech(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TechnologyPage();
        },
      ),
    );
  }

  void navigateToInvestmentOpportunities(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return InvestPage();
        },
      ),
    );
  }

  void navigateToHelp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Help();
        },
      ),
    );
  }

  void farmTap(BuildContext context, int position) {
    if (position == 0) {
      this.goToCBA(context);
    } else {
      this.goToTemplates(context);
    }
  }
}

class _FarmItem {
  final String icon;
  final String title;

  _FarmItem(this.icon, this.title);
}

class _DiseaseItem {
  final String icon;
  final String title;

  _DiseaseItem(this.icon, this.title);
}

class _FeedbackItem {
  final String icon;
  final String title;

  _FeedbackItem(this.icon, this.title);
}

class _MillerItem {
  final String icon;
  final String title;

  _MillerItem(this.icon, this.title);
}

class _NewsItem {
  final String icon;
  final String title;

  _NewsItem(this.icon, this.title);
}

class _MkulimaItem {
  final String icon;
  final String title;

  _MkulimaItem(this.icon, this.title);
}
