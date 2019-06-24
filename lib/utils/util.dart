import 'dart:async' show Future;
import 'dart:convert';

import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/text_util.dart';
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

  static buildFormCity(BuildContext context, List<CityModel> _listCity,
          CityModel _city, SelectCityListener listener) =>
      new FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: Const.size_10, right: Const.size_10),
                labelText: '',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
//            isEmpty: _color == '',
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<CityModel>(
                value: _city,
                isDense: true,
                onChanged: (CityModel newCityModel) {
                  listener.onSelectCity(newCityModel);
                },
                items: _listCity.map((CityModel value) {
                  return new DropdownMenuItem<CityModel>(
                    value: value,
                    child: TextUtil.textDes(context, value.name),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );

  static buildFormDistrict(
          BuildContext context,
          List<DistrictModel> _listDistrict,
          DistrictModel _district,
          SelectDistrictListener listener) =>
      new FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: Const.size_10, right: Const.size_10),
                labelText: '',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
//            isEmpty: _color == '',
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<DistrictModel>(
                value: _district,
                isDense: true,
                onChanged: (DistrictModel newDistrictModel) {
                  listener.onSelectDistrict(newDistrictModel);
                },
                items: _listDistrict.map((DistrictModel value) {
                  return new DropdownMenuItem<DistrictModel>(
                    value: value,
                    child: TextUtil.textDes(context, value.name),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );

  static Widget filterBox(
          BuildContext context,
          List<CityModel> _listCity,
          CityModel _city,
          List<DistrictModel> _listDistrict,
          DistrictModel _district,
          SelectCityListener cityListener,
          SelectDistrictListener districtListener) =>
      SizedBox(
        width: double.infinity,
        height: Const.size_50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: buildFormCity(context, _listCity, _city, cityListener),
            ),
            SizedBox(
              width: 0.5,
              height: Const.size_50,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
            Expanded(
              child: buildFormDistrict(
                  context, _listDistrict, _district, districtListener),
            )
          ],
        ),
      );
}
