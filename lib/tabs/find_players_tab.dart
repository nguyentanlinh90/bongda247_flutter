import 'package:flutter/material.dart';

void main() {
  runApp(FindPlayersTab());
}

class FindPlayersTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FindPlayersTabState();
  }
}

class _FindPlayersTabState extends State<FindPlayersTab> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: new Container(
        child: new Center(
          child: new Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.favorite,
                size: 160.0,
                color: Colors.white,
              ),
              new Text(
                "Find player Tab",
                style: new TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
