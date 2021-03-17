import 'package:flutter/material.dart';
import 'package:InternGymkirchenfeld/main.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:InternGymkirchenfeld/appOptions/settings.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:InternGymkirchenfeld/toDo.dart';
import 'package:InternGymkirchenfeld/appOptions/user.dart';
import 'package:flutter/cupertino.dart';

String currentUrl = 'https://intern.gymkirchenfeld.ch/account/setMobileLayout';

class CrossPScaffold extends StatelessWidget {
  var child;
  var title;
  CrossPScaffold({
    Key key,
    @required this.child,
    @required this.title,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
          navigationBar:  CupertinoNavigationBar(
            middle: Text(title),
          ),
          child: Padding(padding: EdgeInsets.only(top:50),child: child,));
    } else {
      return Scaffold(
         appBar: AppBar(
centerTitle: true,
    
          title: Text(
           title,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
      body: child

    );
    }
  }
}

class DefaultDrawer extends StatefulWidget {
  const DefaultDrawer({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final WebViewController controller;

  @override
  _DefaultDrawerState createState() => _DefaultDrawerState();
}

class _DefaultDrawerState extends State<DefaultDrawer> {
  String userNameShow = '';
  _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userName = prefs.getString('userName') ?? '';

    print(userName);
  }

  void initState() {
    super.initState();
    _nameRetriever();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("HH");
    String currentTime = dateFormat.format(DateTime.now());
    int currentTimeInt = int.parse(currentTime);
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0)),
      child: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FaIcon(
                      (() {
                        if (currentTimeInt < 11) {
                          return FontAwesomeIcons.coffee;
                        } else if (currentTimeInt < 13) {
                          return FontAwesomeIcons.sun;
                        } else if (currentTimeInt < 17) {
                          return FontAwesomeIcons.sun;
                        } else if (currentTimeInt < 23) {
                          return FontAwesomeIcons.cloudMoon;
                        } else if (currentTimeInt < 4) {
                          return FontAwesomeIcons.moon;
                        }
                        return FontAwesomeIcons.coffee;
                      })(),
                      size: 30,
                    ),
                  ),
                  Text(
                    (() {
                      if (currentTimeInt < 11) {
                        return "Guten Morgen $userName";
                      } else if (currentTimeInt < 13) {
                        return "Guten Mittag $userName";
                      } else if (currentTimeInt < 17) {
                        return "Guten Nachmittag $userName";
                      } else if (currentTimeInt < 23) {
                        return "Guten Abend $userName";
                      } else if (currentTimeInt < 4) {
                        return "Gute Nacht $userName";
                      }
                    })(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.home,
              size: 17,
            ),
            title: Text('Hauptseite',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl =
                    'https://intern.gymkirchenfeld.ch/account/setMobileLayout';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.check,
              size: 17,
            ),
            title:
                Text("To Do's ", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TodoList()),
              );
            },
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Unterricht",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.users,
              size: 17,
            ),
            title: Text('Meine Klasse',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl =
                    'https://intern.gymkirchenfeld.ch/schoolClasses/register';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.graduationCap,
              size: 17,
            ),
            title: Text('Meine Kurse',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/course';
              });
            },
          ),
          ListTile(
              leading: FaIcon(
                FontAwesomeIcons.bed,
                size: 17,
              ),
              title: Text('Meine Absenzen',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebtoApp()),
                );
                setState(() {
                  currentUrl =
                      'https://intern.gymkirchenfeld.ch/absence/student/current';
                });
              }),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.clock,
              size: 17,
            ),
            title: Text('Stundenplan',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/timetable';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.sync,
              size: 17,
            ),
            title: Text('Stundenplanänderungen',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl =
                    'https://intern.gymkirchenfeld.ch/register/lessonChanges';
              });
            },
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Schule",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ListTile(
              leading: FaIcon(
                FontAwesomeIcons.user,
                size: 17,
              ),
              title: Text('Personen',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WebtoApp()),
                );
                setState(() {
                  currentUrl = 'https://intern.gymkirchenfeld.ch/people';
                });
              }),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.calendar,
              size: 17,
            ),
            title:
                Text('Termine', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/event';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.cube,
              size: 17,
            ),
            title: Text('Schulprofil',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/student/profile';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.star,
              size: 17,
            ),
            title: Text('myGymer angebote',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl =
                    'https://intern.gymkirchenfeld.ch/optional/student';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.puzzlePiece,
              size: 17,
            ),
            title: Text('Maturarbeit',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/ma/SuS';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.certificate,
              size: 17,
            ),
            title: Text('Portfolios',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl =
                    'https://intern.gymkirchenfeld.ch/student/portfolios';
              });
            },
          ),
          Divider(),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Informationen",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.tv,
              size: 17,
            ),
            title: Text('Anzeigetafel',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/school/screen';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.book,
              size: 17,
            ),
            title: Text('Dokumente',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/document/list';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.link,
              size: 17,
            ),
            title: Text('Linksammlung',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/school/links';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.print,
              size: 17,
            ),
            title: Text('Mein Druckkonto',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );
              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/student/print';
              });
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              size: 17,
            ),
            title: Text('Benutzerlog',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebtoApp()),
              );

              setState(() {
                currentUrl = 'https://intern.gymkirchenfeld.ch/userLog';
              });
            },
          ),
        ],
      )),
    );
  }
}
