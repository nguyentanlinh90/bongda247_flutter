import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city.dart';
import 'package:bongdaphui/models/club.dart';
import 'package:bongdaphui/models/district.dart';
import 'package:bongdaphui/ui/screen/insert_club.dart';
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

//  getAmountPlayer(ClubModel model) async {
//    count = model.players.length;
//    setState(() {});
//  }

  List<ClubModel> _getList(AsyncSnapshot dataSnapshot) {
    List<ClubModel> list = new List();
    List<DocumentSnapshot> documentSnapshots =
        dataSnapshot.data.documents.toList();

    for (int i = 0; i < documentSnapshots.length; i++) {
      ClubModel model = new ClubModel.fromJson(documentSnapshots[i].data);
//      model.setAmountPlayer();

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

  @override
  Widget build(BuildContext context) {
    if (_listCity.length > 0 && _listDistrict.length > 0) {
      return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Auth.getCurrentUser().then((fireBaseUser) {
              if (fireBaseUser == null) {
                Utils.showNotLoginAlert(context);
              } else {
//                Navigator.of(context).pushNamed(Const.insertClubRoute,
//                    arguments: fireBaseUser.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InsertClubScreen(uid: fireBaseUser.uid)),
                );
              }
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green[900],
        ),
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
                                        child: WidgetUtil.postCardClub(context,
                                            _getList(snapshot)[i], _listCity));
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
