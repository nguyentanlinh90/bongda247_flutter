import 'package:flutter/material.dart';

class Util {
  static Widget showLogo() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: 200,
            height: 200,
            child: new Image.asset('images/ic_splash.png'),
          )
        ]);
  }
}
