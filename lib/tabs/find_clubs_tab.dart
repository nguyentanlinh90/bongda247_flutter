import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/models/schedule_club_model.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/text_util.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FindClubsTab());
}

class FindClubsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FindClubsTabState();
  }
}

class _FindClubsTabState extends State<FindClubsTab>
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
    _listCity = await Util.loadCity();
    setState(() {
      _city = _listCity[0];
      _loadListDistrict(_city);
    });
  }

  _loadListDistrict(CityModel cityModel) async {
    _listDistrict = await Util.loadDistrict(cityModel.id);
    setState(() {
      _district = _listDistrict[0];
    });
  }

  List<ScheduleClubModel> _getList(AsyncSnapshot dataSnapshot) {
    List<ScheduleClubModel> list = new List();
    for (var value in dataSnapshot.data.documents) {
      ScheduleClubModel model = new ScheduleClubModel.fromJson(value);
      if (_city.id == model.idCity &&
          ('0' == _district.id || _district.id == model.idDistrict)) {
        list.add(model);
      }
    }
    list.sort((a, b) {
      return a.id.compareTo(b.id);
    });
    return list;
  }

  Widget _fillCard(BuildContext context, ScheduleClubModel model) => Row(
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
              backgroundImage: model.photoUrl.isEmpty
                  ? AssetImage(Const.icPlaying)
                  : NetworkImage(model.photoUrl),
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
              Util.callPhone(model.phone);
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
                TextUtil.textTitle(context, model.nameClub),
                SizedBox(
                  height: Const.size_5,
                ),
                TextUtil.textContent(context, model.phone),
                SizedBox(
                  height: Const.size_5,
                ),
                TextUtil.textContent(context, model.typeField),
                SizedBox(
                  height: Const.size_5,
                ),
                Util.getArea(
                    context, _listCity, model.idCity, model.idDistrict),
                SizedBox(
                  height: Const.size_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextUtil.textContent(context, model.startTime),
                        TextUtil.textDes(context, Const.start)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextUtil.textContent(context, model.endTime),
                        TextUtil.textDes(context, Const.end)
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
    ],
  );

  Widget _postCard(BuildContext context, ScheduleClubModel model) => Card(
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

  @override
  Widget build(BuildContext context) {
    if (_listCity.length > 0 && _listDistrict.length > 0) {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(Const.scheduleClubCollection)
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
                    Util.filterBox(context, _listCity, _city, _listDistrict,
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
                          : Util.showViewNoData(context),
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
