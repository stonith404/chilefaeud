import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'shortcuts/appbar.dart';
import 'appOptions/settings.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[50],
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          cupertinoOverrideTheme: CupertinoThemeData(barBackgroundColor: Colors.black, textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
          appBarTheme: AppBarTheme(
            color: Colors.black87,
          ),
          textTheme: TextTheme(
            subhead: TextStyle(color: Colors.white),
            title: TextStyle(color: Colors.white),
          )),
      home: WebtoApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
 var bwColor = Color(0xFF000000);
WebViewController controller;

class WebtoApp extends StatefulWidget {
  @override
  _WebtoAppState createState() => _WebtoAppState();
}

class _WebtoAppState extends State<WebtoApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _messageText = "Waiting for message...";

  String darkmodejs =
      '''document.getElementsByClassName('navbar ')[0].style.visibility = 'hidden';
           
   javascript: (
function () { 
// the css we are going to inject
var css = 'html {-webkit-filter: invert(100%);' +
    '-moz-filter: invert(100%);' + 
    '-o-filter: invert(100%);' + 
    '-ms-filter: invert(100%); }',

head = document.getElementsByTagName('head')[0],
style = document.createElement('style');



style.type = 'text/css';
if (style.styleSheet){
style.styleSheet.cssText = css;
} else {
style.appendChild(document.createTextNode(css));
}

//injecting the css to the head
head.appendChild(style);
}());
''';

  String lightmodejs =
      '''document.getElementsByClassName('navbar ')[0].style.visibility = 'hidden';
      
         javascript: (
function () { 
// the css we are going to inject
var css = 'html {-webkit-filter: invert(0%);' +
    '-moz-filter: invert(0%);' + 
    '-o-filter: invert(0%);' + 
    '-ms-filter: invert(0%); }',

head = document.getElementsByTagName('head')[0],
style = document.createElement('style');

style.type = 'text/css';
if (style.styleSheet){
style.styleSheet.cssText = css;
} else {
style.appendChild(document.createTextNode(css));
}

//injecting the css to the head
head.appendChild(style);
}());
      ''';

  bool darkModeOn = false;

  @override
  Timer timer;
  void didChangePlatformBrightness() {
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      final brightness = window.platformBrightness;
     Navigator.pushReplacement(
      context, 
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => WebtoApp(),
        transitionDuration: Duration(seconds: 0),
    ),
);
    };
  }


  darkModeColorChanger() {
    var brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      setState(() {
        bwColor = Color(0xFFffffff);
        darkModeOn = true;
      });
    } else {
      bwColor = Color(0xFF000000);
      darkModeOn = false;
    }
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => didChangePlatformBrightness());

    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => darkModeColorChanger());

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "Push Messaging message: $message";
        });
        print("onResume: $message");
      },
    );

// Asks permission for push notifcations in ios
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  bool isLoading = true;

  static const dcolor = Color(0xFF3348b5);
  var connectionStatus = false;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        connectionStatus = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        connectionStatus = true;
      });
    } else {
      setState(() {
        connectionStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: check(), // a previously-obtained Future or null
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (connectionStatus == true) {
            //if Internet is connected
            return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      "chilefäud",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon:  FaIcon(
                          FontAwesomeIcons.ellipsisH,
                          size: 17,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppOptions(
                                    controller: controller, context: context)),
                          );
                        },
                      )
                    ],
                  ),
                  drawer: DefaultDrawer(controller: controller),
body: Stack(children: <Widget>[
                  WebView(
                    initialUrl:
                      currentUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller = webViewController;
                    },
                    onPageStarted: (String url) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onPageFinished: (String url) {
                      setState(() {
                        isLoading = false;
                      });
                      var brightness =
                          MediaQuery.of(context).platformBrightness;
                      if (brightness == Brightness.dark) {
                        setState(() {
                          darkModeOn = true;
                        });
                      } else {
                        darkModeOn = false;
                      }

                      if (darkModeOn == true) {
                        controller.evaluateJavascript(darkmodejs);
                        print("dark");
                      } else {
                        controller.evaluateJavascript(lightmodejs);
                        print("light");
                      }
                    },
                  ),
                  isLoading
                      ? Scaffold(
                          body: SpinKitDoubleBounce(color: bwColor),
                        )
                      : Stack(),
                ]),
              
            );
          } else {
            //If internet is not connected
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "chilefäud",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                actions: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.cog,
                      size: 17,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppOptions(
                                controller: controller, context: context)),
                      );
                    },
                  )
                ],
              ),
              drawer: DefaultDrawer(
                controller: controller,
              ),
              body: Column(
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  Image.asset('assets/images/noWifi.png', height: 250),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Internetverbindung",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Du brauchtst Internet, bitte schalte es an um die App zu nutzen.",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
            );
          }
        });
  }
}
