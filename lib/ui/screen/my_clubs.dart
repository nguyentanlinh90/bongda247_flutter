import 'package:bongdaphui/models/city.dart';
import 'package:bongdaphui/models/club.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';

class MyClubsScreen extends StatefulWidget {
  MyClubsScreen({Key key, this.userModel}) : super(key: key);
  final UserModel userModel;

  State<StatefulWidget> createState() {
    return _MyClubsScreenState();
  }
}

class _MyClubsScreenState extends State<MyClubsScreen> {
  List<CityModel> _listCity = List();

  _loadListCity() async {
    _listCity = await Utils.loadCity();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadListCity();
  }

  List<dynamic> _getList() {
    List<ClubModel> list = List();
    for (int i = 0; i < widget.userModel.clubs.length; i++) {
      ClubModel clubModel = ClubModel.fromJson(widget.userModel.clubs[i]);
      list.add(clubModel);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: WidgetUtil.appBar(Const.myClubs),
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Expanded(
                child: _getList().length > 0
                    ? Scrollbar(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8.0),
                            itemCount: _getList().length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                  onTap: () => print(i),
                                  child: WidgetUtil.postCardClub(
                                      context, _getList()[i], _listCity));
                            }))
                    : WidgetUtil.showViewNoData(context),
              )
            ],
          )),
    );
  }
}
