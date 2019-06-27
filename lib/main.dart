import 'package:bongdaphui/ui/screen/home_screen.dart';
import 'package:bongdaphui/ui/screen/insert_schedule.dart';
import 'package:bongdaphui/ui/screen/notfound_screen.dart';
import 'package:bongdaphui/ui/screen/sigin_signup_screen.dart';
import 'package:bongdaphui/ui/screen/sign_in_screen.dart';
import 'package:bongdaphui/ui/screen/sign_up_screen.dart';
import 'package:bongdaphui/ui/screen/splash_creen.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//    systemNavigationBarColor: Colors.blue,
    statusBarColor: Colors.green[900],
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
        title: Const.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: SplashScreen(),
        //routes
        routes: <String, WidgetBuilder>{
          Const.mainRoute: (BuildContext context) => HomeScreen(),
          Const.signInRoute: (BuildContext context) => new SignInScreen(),
          Const.signUpRoute: (BuildContext context) => new SignUpScreen(),
          Const.welcomeRoute: (BuildContext context) => SignInSignUpScreen(),
          Const.insertSchedulePlayerRoute: (BuildContext context) =>
              InsertScheduleScreen(),
        },
        onUnknownRoute: (RouteSettings rs) =>
            new MaterialPageRoute(builder: (context) => new NotFoundScreen()));
  }
}
