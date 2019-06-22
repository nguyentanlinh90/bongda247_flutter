import 'package:bongdaphui/ui/screen/notfound_screen.dart';
import 'package:bongdaphui/ui/screen/splash_creen.dart';
import 'package:bongdaphui/ui/screen/welcome_screen.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Const.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: SplashScreen(),
        //routes
        routes: <String, WidgetBuilder>{
          Const.welcomeRoute: (BuildContext context) => WelcomeScreen(),
        },
        onUnknownRoute: (RouteSettings rs) =>
            new MaterialPageRoute(builder: (context) => new NotFoundScreen()));
  }
}
