import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:InternGymkirchenfeld/shortcuts/appbar.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  List<String> attachments = [];

  final _recipientController = TextEditingController(
    text: 'elias@eliasschneider.com',
  );

  final _subjectController =
      TextEditingController(text: 'Chilefäud Feature Vorschlag');

  final _bodyController = TextEditingController(
    text: '',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Super, es hat funktioniert!';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
                  
         
                  actions: <Widget>[
            IconButton(
              onPressed: send,
              icon: Icon(Icons.send),
            )
          ],
          title: Text(
            "feature vorschlag",
            style: TextStyle(fontWeight: FontWeight.w300,),
          ),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
                  child: TextField(
                    controller: _bodyController,
                    maxLines: 10,
                    decoration: InputDecoration(
                        labelText: 'Feature Vorschlag eingeben...',
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    "Nach dem Absenden wirst du zu deiner Mail App weitergeleitet, sende dort nochmals ab.",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          
        ),
      ),
    );
  }
}
