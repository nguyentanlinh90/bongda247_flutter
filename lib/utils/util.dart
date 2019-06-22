import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

class Util {
  static Widget showLogo() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            width: 200,
            height: 200,
            child: new Image.asset(Const.icSplash),
          )
        ]);
  }
}
