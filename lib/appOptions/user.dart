import 'package:flutter/material.dart';
import 'package:InternGymkirchenfeld/shortcuts/appbar.dart';
import 'package:InternGymkirchenfeld/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userName = "";

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

TextEditingController userNameController = new TextEditingController();

String input = "";

_nameRetriever() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  userName = prefs.getString('userName') ?? '';

  print(userName);
}

String successText = "";

_nameSaver() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('userName', input);
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "benutzer einstellungen",
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 20),
              child: FaIcon(
                FontAwesomeIcons.user,
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
                  TextField(
                    controller: userNameController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Dein Name...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () async {
                  input = userNameController.text;
                  _nameSaver();
                  _nameRetriever();
                  setState(() {
                    successText = "gespeichert.";
                  });

                  print(successText);
                  await Future.delayed(const Duration(seconds: 4), () {
                    setState(() {
                      successText = "";
                    });
                  });
                },
                child: Text("speichern", style: TextStyle(color: Colors.black),)),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                successText,
                style: TextStyle(color: Colors.green),
              ),
            )
          ],
        ));
  }
}
