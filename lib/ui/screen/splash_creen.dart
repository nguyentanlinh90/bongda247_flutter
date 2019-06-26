import 'package:bongdaphui/models/tutorial_model.dart';
import 'package:bongdaphui/ui/screen/home_screen.dart';
import 'package:bongdaphui/ui/screen/tutorial_screen.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/shared_preferences.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  bool seen = false;

  @override
  void initState() {
    super.initState();
    _checkSeenTutorial();
  }

  _checkSeenTutorial() async {
    seen = await SharedPreferencesUtil.getSeenTutorialPrefs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: Stack(
          children: <Widget>[
            Center(child: WidgetUtil.showLogo()),
            _handleCurrentScreen()
          ],
        ),
      ),
    );
  }

  List<Tutorial> getList(AsyncSnapshot dataSnapshot) {
    List<Tutorial> list = new List();

    for (var value in dataSnapshot.data.documents) {
      list.add(new Tutorial.fromJson(value));
    }
    return list;
  }

  Widget _handleCurrentScreen() {
    if (seen) {
      return HomeScreen();
    } else {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(Const.tutorialCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return TutorialScreen(list: getList(snapshot));
            }),
      );
    }
  }
}
