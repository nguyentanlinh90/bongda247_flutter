import 'dart:async' show Future;
import 'dart:convert';

import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
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

  static Future<List<CityModel>> loadCity() async {
    String jsonString = await _loadCityAsset();
    List responseJson = json.decode(jsonString);
    return responseJson.map((m) => new CityModel.fromJson(m)).toList();
  }

  static Future<List<DistrictModel>> loadDistrict(String idCity) async {
    List<DistrictModel> districtList = List();
    List<CityModel> cityList = await loadCity();
    for (int i = 0; i < cityList.length; i++) {
      if ((idCity == cityList[i].id)) {
        List modelList = cityList[i].districts;
        districtList =
            modelList.map((m) => new DistrictModel.fromJson(m)).toList();
      }
    }
    return districtList;
  }

  static Widget showViewNoData(BuildContext context) {
    return new Center(
      child: Text('Chưa có dữ liệu',
          style: Theme.of(context)
              .textTheme
              .body1
              .apply(fontFamily: Const.ralewayFont, color: Colors.grey[900])),
    );
  }
}
