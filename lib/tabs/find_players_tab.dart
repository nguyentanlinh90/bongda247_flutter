import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/models/match_model.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindPlayersTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FindPlayersTabState();
  }
}

class _FindPlayersTabState extends State<FindPlayersTab>
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

  List<MatchModel> _getList(AsyncSnapshot dataSnapshot) {
    List<MatchModel> list = new List();
    for (var value in dataSnapshot.data.documents) {
      MatchModel model = new MatchModel.fromJson(value);
      if (_city.id == model.city &&
          ('0' == _district.id || _district.id == model.district)) {
        list.add(model);
      }
    }
    list.sort((a, b) {
      return a.from.compareTo(b.from);
    });
    return list;
  }

  Widget _fillCard(BuildContext context, MatchModel model) => Row(
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
                  backgroundImage: model.photo.isEmpty
                      ? AssetImage(Const.icPlaying)
                      : NetworkImage(model.photo),
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
                  Utils.callPhone(model.phone);
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
                WidgetUtil.textTitle(context, model.name),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.contact_),
                    WidgetUtil.textContent(context, model.phone),
                  ],
                ),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.typeField),
                    WidgetUtil.textContent(context, model.typeField),
                  ],
                ),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.area),
                    Utils.getArea(
                        context, _listCity, model.city, model.district)
                  ],
                ),
                SizedBox(
                  height: Const.size_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(context, model.from),
                        WidgetUtil.textBody1Grey(context, Const.start)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(context, model.to),
                        WidgetUtil.textBody1Grey(context, Const.end)
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );

  Widget _postCard(BuildContext context, MatchModel model) => Card(
        margin: const EdgeInsets.only(
            left: Const.size_8, right: Const.size_8, bottom: Const.size_8),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(Const.size_8),
              child: _fillCard(context, model),
            ),
            SizedBox(
              height: Const.size_5,
            ),
          ],
        ),
      );

  void _showNotLoginAlert(
      {String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_listCity.length > 0 && _listDistrict.length > 0) {
      return new Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*Navigator.of(context).pushNamed(Const.insertSchedulePlayerRoute,
                arguments: ScreenArguments(true, false));*/
            _showNotLoginAlert(
              title: Const.alert,
              content: Const.youNeedLogin,
              onPressed: null,
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[900],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(Const.matchCollection)
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
