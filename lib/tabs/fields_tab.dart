import 'package:flutter/material.dart';

void main() {
  runApp(FieldsTab());
}

class FieldsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FieldsTabState();
  }
}

class _FieldsTabState extends State<FieldsTab> {
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
                "Field Tab",
                style: new TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
