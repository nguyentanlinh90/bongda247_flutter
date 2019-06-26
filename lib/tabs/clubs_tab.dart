import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/club_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClubsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClubsTabState();
  }
}

class _ClubsTabState extends State<ClubsTab>
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

  int count = 0;

  getAmountPlayer(ClubModel model) async {
    count = model.players.length;
    setState(() {});
  }

  List<ClubModel> _getList(AsyncSnapshot dataSnapshot) {
    List<ClubModel> list = new List();
    List<DocumentSnapshot> documentSnapshots =
        dataSnapshot.data.documents.toList();

    for (int i = 0; i < documentSnapshots.length; i++) {
      ClubModel model = new ClubModel.fromJson(documentSnapshots[i].data);
      model.setAmountPlayer();

      if (_city.id == model.idCity &&
          ('0' == _district.id || _district.id == model.idDistrict)) {
        list.add(model);
      }
    }

    list.sort((a, b) {
      return a.name.compareTo(b.name);
    });
    return list;
  }

  Widget _fillCard(BuildContext context, ClubModel model) => Row(
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
                        : NetworkImage(model.photo)),
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
                    WidgetUtil.textBody1Grey(context, Const.captain),
                    WidgetUtil.textContent(context, model.caption)
                  ],
                  verticalDirection: VerticalDirection.up,
                ),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.area),
                    Utils.getArea(
                        context, _listCity, model.idCity, model.idDistrict)
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
                        WidgetUtil.textContent(context, model.phone),
                        WidgetUtil.textBody1Grey(context, Const.contact)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(context, model.amountPlayer),
                        WidgetUtil.textBody1Grey(context, Const.countPlayer)
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );

  Widget _postCard(BuildContext context, ClubModel model) => Card(
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
            stream:
                Firestore.instance.collection(Const.clubCollection).snapshots(),
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
