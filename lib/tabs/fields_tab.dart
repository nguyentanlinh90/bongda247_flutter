import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city.dart';
import 'package:bongdaphui/models/district.dart';
import 'package:bongdaphui/models/soccer_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class FieldsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FieldsTabState();
  }
}

class _FieldsTabState extends State<FieldsTab>
    implements SelectCityListener, SelectDistrictListener {
  List<CityModel> _listCity = List();
  List<DistrictModel> _listDistrict = List();
  CityModel _city;
  DistrictModel _district;

  @override
  void onSelectCity(CityModel model) {
    setState(() {
      _city = model;
      _loadListDistrict(_city);
    });
  }

  @override
  void onSelectDistrict(DistrictModel model) {
    setState(() {
      _district = model;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadListCity();
  }

  _loadListCity() async {
    _listCity = await Utils.loadCity();
    setState(() {
      _city = _listCity[0];
      _loadListDistrict(_city);
    });
  }

  _loadListDistrict(CityModel cityModel) async {
    _listDistrict = await Utils.loadDistrict(cityModel.id);
    setState(() {
      _district = _listDistrict[0];
    });
  }

  List<SoccerFieldModel> _getList(AsyncSnapshot dataSnapshot) {
    List<SoccerFieldModel> list = new List();
    for (var value in dataSnapshot.data.documents) {
      SoccerFieldModel soccerField = new SoccerFieldModel.fromJson(value);
      if (_city.id == soccerField.idCity &&
          ('0' == _district.id || _district.id == soccerField.idDistrict)) {
        list.add(soccerField);
      }
    }
    list.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return list;
  }

  _selectPhone(BuildContext context, String phone1, String phone2) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: WidgetUtil.textContent(context, Const.selectPhone),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  child: WidgetUtil.textTitle(context, phone1),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Utils.callPhone(phone1);
                  },
                ),
                FlatButton(
                  child: WidgetUtil.textTitle(context, phone2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Utils.callPhone(phone2);
                  },
                )
              ],
            ));
      },
    );
  }

  _priceAVG(String price, String priceMax) {
    String _price = Const.threeDot;
    String _priceMax = Const.threeDot;

    if (price.isNotEmpty) {
      _price = FlutterMoneyFormatter(amount: double.parse(price))
          .output
          .withoutFractionDigits;
    }

    if (priceMax.isNotEmpty) {
      _priceMax = FlutterMoneyFormatter(amount: double.parse(priceMax))
          .output
          .withoutFractionDigits;
    }
    return '$_price ~ $_priceMax';
  }

  _showPhoneNumber(String phone, String phone2) {
    if (phone2.isEmpty) {
      return phone;
    } else {
      return '$phone - $phone2';
    }
  }

  Widget _fillCard(BuildContext context, SoccerFieldModel field) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Const.size_60,
                height: Const.size_60,
                child: CircleAvatar(
                  backgroundColor: Colors.green[900],
                  backgroundImage: field.photoUrl.isEmpty
                      ? AssetImage(Const.icPlaying)
                      : NetworkImage(field.photoUrl),
                ),
              ),
              SizedBox(
                height: Const.size_10,
              ),
              IconButton(
                icon: Icon(
                  Icons.phone,
                  color: Colors.green[900],
                  size: Const.size_35,
                ),
                onPressed: () {
                  if (field.phone2.isEmpty) {
                    Utils.callPhone(field.phone);
                  } else {
                    _selectPhone(context, field.phone, field.phone2);
                  }
                },
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WidgetUtil.textTitle(context, field.name),
                SizedBox(
                  height: Const.size_5,
                ),
                WidgetUtil.textContent(
                    context, _showPhoneNumber(field.phone, field.phone2)),
                SizedBox(
                  height: Const.size_5,
                ),
                WidgetUtil.textContent(context, field.address),
                SizedBox(
                  height: Const.size_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(
                            context,
                            field.amountField.isEmpty
                                ? Const.threeDot
                                : field.amountField),
                        WidgetUtil.textBody1Grey(context, Const.countField)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(
                            context, _priceAVG(field.price, field.priceMax)),
                        WidgetUtil.textBody1Grey(context, Const.priceAVG)
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );

  Widget _postCard(BuildContext context, SoccerFieldModel field) => Card(
        margin: const EdgeInsets.only(
            left: Const.size_8, right: Const.size_8, bottom: Const.size_8),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(Const.size_8),
              child: _fillCard(context, field),
            ),
            SizedBox(
              height: Const.size_5,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    if (_listCity.length > 0 && _listDistrict.length > 0) {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(Const.fieldsCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.green[900])));
              return SafeArea(
                child: Column(
                  children: <Widget>[
                    Utils.filterBox(context, _listCity, _city, _listDistrict,
                        _district, this, this),
                    SizedBox(
                      height: 0.5,
                      width: double.infinity,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: _getList(snapshot).length > 0
                          ? Scrollbar(
                              child: ListView.builder(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  itemCount: _getList(snapshot).length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                        onTap: () => print(i),
                                        child: _postCard(
                                            context, _getList(snapshot)[i]));
                                  }))
                          : WidgetUtil.showViewNoData(context),
                    )
                  ],
                ),
              );
            }),
      );
    } else {
      return Center(
          child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.green[900])));
    }
  }
}
