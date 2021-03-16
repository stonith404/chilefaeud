import 'package:flutter/material.dart';
import 'package:InternGymkirchenfeld/shortcuts/appbar.dart';
import 'package:InternGymkirchenfeld/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DarkMode extends StatefulWidget {
  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      
         
          title: Text(
            "Darkmode",
            style: TextStyle(fontWeight: FontWeight.w300,),
          ),
        ),
        body: Column(
          children: [
            
            Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 20),
              child: FaIcon(
                FontAwesomeIcons.moon,
                size: 60,
       
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                children: [
                  Text(
                    "Der Darkmode ist hier! Indem du den Darkmode auf deinem Handy aktivierst, ist die App dunkel. Diese Fehler werden noch verbessert: Bilder werden falsch dargestellt.",
                    style: TextStyle(fontSize: 17),
                  ),
                 
                ],
              ),
            )
          ],
        ));
  }
}
