import 'dart:async' show Future;
import 'dart:convert';

import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:random_string/random_string.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
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

  static buildFormCity(BuildContext context, List<CityModel> _listCity,
          CityModel _city, SelectCityListener listener) =>
      new FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: Const.size_10),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
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
                    child: WidgetUtil.textBody1Grey(context, value.name),
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
                    child: WidgetUtil.textBody1Grey(context, value.name),
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
          crossAxisAlignment: CrossAxisAlignment.center,
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

  static Widget getArea(BuildContext context, List<CityModel> _listCity,
      String idCity, String idDistrict) {
    String area = '';
    for (int i = 0; i < _listCity.length; i++) {
      if (idCity == _listCity[i].id) {
        List modelList = _listCity[i].districts;
        List<DistrictModel> _listDistrict =
            modelList.map((m) => new DistrictModel.fromJson(m)).toList();
        for (int j = 0; j < _listDistrict.length; j++) {
          if (idDistrict == _listDistrict[j].id) {
            area = '${_listDistrict[j].name}, ${_listCity[i].name}';
          }
        }
      }
    }
    return WidgetUtil.textContent(context, area);
  }

  static String randomString(int characters) {
    return randomNumeric(characters);
  }
}
