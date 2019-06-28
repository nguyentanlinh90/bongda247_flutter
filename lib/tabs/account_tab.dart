import 'package:bongdaphui/ui/screen/account_screen.dart';
import 'package:bongdaphui/ui/screen/sigin_signup_screen.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountTabState();
  }
}

class _AccountTabState extends State<AccountTab> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        isLogin = user != null;
      });
    });
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

  Widget _handleCurrentScreen() {
    if (isLogin) {
      return new Scaffold(
          backgroundColor: Colors.white,
          body: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return WidgetUtil.progress();
              } else {
                if (snapshot.hasData) {
                  return AccountScreen(uid: snapshot.data.uid);
                } else {
                  return SignInSignUpScreen();
                }
              }
            },
          ));
    } else {
      return SignInSignUpScreen();
    }
  }
}
