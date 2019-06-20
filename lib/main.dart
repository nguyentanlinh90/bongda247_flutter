import 'package:bongdaphui/pages/root_page.dart';
import 'package:bongdaphui/services/authentication.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bóng Đá Phủi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: new RootPage(auth: new Auth()),
    );
  }
}
