import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appOptions/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'shortcuts/appbar.dart';
import 'appOptions/settings.dart';
import 'main.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [''];
  List<String> todoItemsS = [];

  void _addTodoItem(String task) async {
    // Only add the task if the user actually entered something
    if (task.length > 0) {
      // Putting our code inside "setState" tells the app that our state has changed, and
      // it will automatically re-render the list

      final prefs = await SharedPreferences.getInstance();

      _todoItems = prefs.getStringList('todoItems');

      setState(() => _todoItems.add(task));

      prefs.setStringList('todoItems', _todoItems);
    }
  }

  void _removeTodoItem(int index) async {
    final prefs = await SharedPreferences.getInstance();

    _todoItems = prefs.getStringList('todoItems');

    setState(() => _todoItems.removeAt(index));

    prefs.setStringList('todoItems', _todoItems);

     Navigator.pushReplacement(
      context, 
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => TodoList(),
        transitionDuration: Duration(seconds: 0),
    ),
);
  }

  gettodoIdems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _todoItems = prefs.getStringList('todoItems');
    });
    if (_todoItems == null) {
      _todoItems = [];
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('todoItems', _todoItems);
    }
// Try reading data from the counter key. If it doesn't exist, return 0.

    // print("SP" + _todoItems.toString());
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    gettodoIdems();
    return Dismissible(
      direction: DismissDirection.horizontal,
      // Each Dismissible must contain a Key. Keys allow Flutter to
      // uniquely identify widgets.
      key: Key(index.toString()),
      // Provide a function that tells the app
      // what to do after an item has been swiped away.
      onDismissed: (direction) {
        // Remove the item from the data source.
        _removeTodoItem(index);
        // Then show a snackbar.
        
      },
      // Show a red background as the item is swiped away.
      background: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        alignment: AlignmentDirectional.centerEnd,
       
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.check),
              Icon(Icons.check),
            ],
          ),
        ),
      ),

      child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.blueAccent, Colors.blue]),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(title: new Text(todoText, style: TextStyle(color: Colors.white),))),
    );
  }

  @override
  Widget build(BuildContext context) {
    gettodoIdems();
    DateFormat dateFormat = DateFormat("HH");
    String currentTime = dateFormat.format(DateTime.now());
    int currentTimeInt = int.parse(currentTime);
    return new Scaffold(
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
            icon: FaIcon(
              FontAwesomeIcons.cog,
              size: 17,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AppOptions(controller: controller, context: context)),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "To Do's",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: FaIcon(
                  FontAwesomeIcons.plusSquare,
         
                ),
                    onPressed:  _pushAddTodoScreen)
                    
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),

              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  // itemBuilder will be automatically be called as many times as it takes for the
                  // list to fill up its available space, which is most likely more than the
                  // number of todo items we have. So, we need to check the index is OK.

                  gettodoIdems();

                  if (index < _todoItems.length) {
                    return _buildTodoItem(_todoItems[index], index);
                  }
                },
              ),
            ),
          ),
        ],
      ),
       
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well as adding
        // a back button to close it
        new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('neues to do')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Wie soll dein To Do heissen?',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
