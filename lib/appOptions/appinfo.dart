import 'package:flutter/material.dart';
import 'package:InternGymkirchenfeld/shortcuts/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:get_version/get_version.dart';
import 'package:flutter/services.dart';
import 'package:InternGymkirchenfeld/appOptions/devInfo.dart';

class AppInfo extends StatefulWidget {
  @override
  _AppInfoState createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }

  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "über d' app",
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 70, 0, 20),
                child: GestureDetector(
                    onTap: () {
                      int now = DateTime.now().millisecondsSinceEpoch;
                      if (now - lastTap < 1000) {
                        print("Consecutive tap");
                        consecutiveTaps++;
                        print("taps = " + consecutiveTaps.toString());
                        if (consecutiveTaps > 8) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DevInfo()),
                          );
                        }
                      } else {
                        consecutiveTaps = 0;
                      }
                      lastTap = now;
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child:
                            Image.asset('assets/icon/logo.jpg', height: 100)))),
            Text("Version: " + _projectVersion),
            Text("Build: " + _projectCode),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Divider(),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Text(
                  "Bitte beachte, dass dies keine offizielle App von dem Gymnasium Kirchenfeld ist. Sie greift zwar auf die Website intern.gymkirchenfeld zu, aber veröffentlicht wurde die App nicht vom Gymnasium Kirchenfeld."),
            ),
         Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(bottom: 14.0),
              child: Text("entwickelt von elias schneider", style: TextStyle(fontStyle: FontStyle.italic),),
            )
          ],
        ));
  }
}