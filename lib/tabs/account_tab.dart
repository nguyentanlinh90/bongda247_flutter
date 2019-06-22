import 'package:flutter/material.dart';
import 'package:bongdaphui/ui/screen/sigin_signup_screen.dart';

void main() {
  runApp(AccountTab());
}

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
      body: new SignInSignUpScreen(),
    );
  }
}
