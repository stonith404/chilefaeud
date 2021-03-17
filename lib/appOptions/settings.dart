import 'package:InternGymkirchenfeld/appOptions/appinfo.dart';
import 'package:InternGymkirchenfeld/shortcuts/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'user.dart';
import 'package:InternGymkirchenfeld/appOptions/featureVorschlag.dart';
import 'appinfo.dart';

class AppOptions extends StatelessWidget {
  @override
  const AppOptions({
    Key key,
    @required this.controller,
    @required this.context,
  }) : super(key: key);

  final WebViewController controller;
  final BuildContext context;

  Widget build(BuildContext context) {
    return CrossPScaffold(child: _body(controller: controller), title: "istellige");
  }
}


class _body extends StatelessWidget {
  const _body({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.userAlt,
              size: 17,
            ),
            title: Text('Benutzer Info',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pop();
              controller
                  .loadUrl('https://intern.gymkirchenfeld.ch/people/detail');
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.user,
              size: 17,
            ),
            title: Text('Benutzer Einstellungen',
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User()),
              );
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.signOutAlt,
              size: 17,
            ),
            title:
                Text('Ausloggen', style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.of(context).pop();
              controller
                  .loadUrl('https://intern.gymkirchenfeld.ch/account/logout');
            },
          ),
          
          Divider(
            height: 20,
            thickness: 1,
          ),
          ListTile(
              leading: FaIcon(
                FontAwesomeIcons.info,
                size: 17,
              ),
              title:
                  Text('App Info', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppInfo()),
                );
              }),
          ListTile(
              leading: FaIcon(
                FontAwesomeIcons.arrowUp,
                size: 17,
              ),
              title: Text('Feature Vorschlag',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactForm()),
                );
              }),
          ListTile(
              leading: FaIcon(
                FontAwesomeIcons.star,
                size: 17,
              ),
              title: Text('App bewerten',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                if (Platform.isIOS) {
                  _launchAppStore();
                }
                if (Platform.isAndroid) {
                  _launchPlayStore();
                }
              }),
        ],
      ),
    );
  }
}

_launchAppStore() async {
  const url = 'https://apps.apple.com/app/chilef%C3%A4ud/id1546252550';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Da ist leider ein Fehler aufgetreten...';
  }
}

_launchPlayStore() async {
  const url =
      'https://play.google.com/store/apps/details?id=com.eliasschneider.gymkirchenfeld';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Da ist leider ein Fehler aufgetreten...';
  }
}
