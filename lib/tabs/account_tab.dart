import 'package:bongdaphui/ui/screen/root_screen.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountTabState();
  }
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: new RootScreen(),
    );
  }
}
