import 'package:bongdaphui/models/tutorial_model.dart';
import 'package:bongdaphui/ui/screen/insert_match.dart';
import 'package:bongdaphui/ui/screen/main_screen.dart';
import 'package:bongdaphui/ui/screen/notfound_screen.dart';
import 'package:bongdaphui/ui/screen/sign_in_screen.dart';
import 'package:bongdaphui/ui/screen/sign_up_screen.dart';
import 'package:bongdaphui/ui/screen/tutorial_screen.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/shared_preferences.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//    systemNavigationBarColor: Colors.blue,
    statusBarColor: Colors.green[900],
  ));
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        title: Const.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: _handleCurrentScreen(),
        //routes
        routes: <String, WidgetBuilder>{
          Const.mainRoute: (BuildContext context) => MainScreen(),
          Const.insertMatchRoute: (BuildContext context) =>
              InsertMatchScreen(),
        },
        onUnknownRoute: (RouteSettings rs) =>
            new MaterialPageRoute(builder: (context) => new NotFoundScreen()));
  }

  Widget _handleCurrentScreen() {
    bool seen =
        (prefs.getBool(SharedPreferencesUtil.seenTutorialPrefs) ?? false);

    if (seen) {
      return new MainScreen();
    } else {
      return new Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance
                .collection(Const.tutorialCollection)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return WidgetUtil.progress();
              return TutorialScreen(list: getList(snapshot));
            }),
      );
    }
  }

  List<Tutorial> getList(AsyncSnapshot dataSnapshot) {
    List<Tutorial> list = new List();

    for (var value in dataSnapshot.data.documents) {
      list.add(new Tutorial.fromJson(value));
    }
    return list;
  }
}
