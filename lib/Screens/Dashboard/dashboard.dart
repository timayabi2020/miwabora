import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:miwabora/Screens/Feedback/complaints.dart';
import 'package:miwabora/Screens/Feedback/questions.dart';
import 'package:miwabora/Screens/Login/login.dart';
import 'package:miwabora/Screens/Profile/profile_breif.dart';
import 'package:miwabora/constants.dart';

class Dashboard extends StatefulWidget {
  Map<String, String>? resultsMap;
  Dashboard(Map<String, String> details) {
    this.resultsMap = details;
  }

  @override
  _DashboardState createState() => _DashboardState(resultsMap);
}

class _DashboardState extends State<Dashboard> {
  Map<String, String>? details;
  String? _username;
  String? _phone;
  String? _email;
  String? _userId;
  _DashboardState(Map<String, String>? resultsMap) {
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

    setState(() {
      _username = username;
      _email = email;
      _phone = phone;
      _userId = userId;
    });
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  children: [
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
                    //_displayDialog(context);
                  }),
              onTap: () {
                //_displayDialog(context);
              },
            ),
            ListTile(
              title: Text('Help'),
              leading: new IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    //_displayDialog(context);
                  }),
              onTap: () {
                //_displayDialog(context);
              },
            ),
            ListTile(
              title: Text('Share'),
              leading: new IconButton(
                  icon: Icon(Icons.share),
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
                        //openServices(position, context);
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
                                        // openServices(
                                        //   position, context);
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
                        // doPayment(position, context);
                        //openServices(position, context);
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
                                        //   position, context);
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
                        //openServices(position, context);
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
                                        // openServices(
                                        //   position, context);
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

  void navigateToLogin(BuildContext context) {
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
