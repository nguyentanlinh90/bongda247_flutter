import 'dart:async' show Future;
import 'dart:convert';

import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

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

  static callPhone(String phone) {
    launch("tel://$phone");
  }

  static Future<String> _loadCityAsset() async {
    return await rootBundle.loadString(Const.jsonCity);
  }

  static Future loadCity() async {
    String jsonString = await _loadCityAsset();
    _parseJsonForCity(jsonString);
  }

  static List<CityModel> _parseJsonForCity(String jsonString) {
    List<CityModel> cityList = List();
    List responseJson = json.decode(jsonString);
    cityList = responseJson.map((m) => new CityModel.fromJson(m)).toList();
    return cityList[0].districts;
  }
}
