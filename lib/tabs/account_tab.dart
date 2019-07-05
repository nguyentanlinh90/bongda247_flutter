import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/ui/screen/my_clubs.dart';
import 'package:bongdaphui/ui/screen/sign_in_screen.dart';
import 'package:bongdaphui/ui/screen/sign_up_screen.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/ui/widgets/menu_row_three.dart';
import 'package:bongdaphui/utils/const.dart';
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
  final int isLoginValue = 1;
  final isNotLoginValue = 2;
  int isLogin = 0;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    _checkLogged();
  }

  _checkLogged() async {
    Auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          isLogin = isLoginValue;
        } else {
          isLogin = isNotLoginValue;
        }
      });
    });
  }

  _logOut() {
    Auth.signOut();
    setState(() {
      isLogin = isNotLoginValue;
    });
  }

  _questionSignOut() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return CustomAlertDialog(
            title: Const.alert,
            content: Const.youWantSignOut,
            leftText: Const.no,
            rightText: Const.yes,
            rightOnPressed: () => _logOut(),
          );
        });
  }

  _buttonTapped(bool isSignIn) async {
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return isSignIn ? SignInScreen() : SignUpScreen();
      },
    ));

    if (results != null && results.containsKey(Const.signInData)) {
      setState(() {
        print('linhnt==== ${results[Const.signInData]}');
        _checkLogged();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    if (isLogin == isLoginValue) {
      return new Scaffold(
          body: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return WidgetUtil.progress();
          } else {
            if (snapshot.hasData) {
              return _accountScreen(snapshot.data.uid);
            } else {
              _signInSignUpScreen();
            }
          }
        },
      ));
    } else if (isLogin == isNotLoginValue) {
      return _signInSignUpScreen();
    } else {
      return WidgetUtil.progress();
    }
  }

  _accountScreen(String uid) => SafeArea(
        child: Scaffold(
          body: StreamBuilder(
            stream: Auth.getUser(uid),
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.green[900],
                    ),
                  ),
                );
              } else {
                userModel = snapshot.data;
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      WidgetUtil.heightBox10(),
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: CircleAvatar(
                          backgroundImage: (snapshot
                                  .data.profilePictureURL.isNotEmpty)
                              ? NetworkImage(snapshot.data.profilePictureURL)
                              : AssetImage(Const.icDefault),
                        ),
                      ),
                      WidgetUtil.heightBox10(),
                      WidgetUtil.textContent(context, snapshot.data.fullName),
                      WidgetUtil.heightBox5(),
                      WidgetUtil.textBody1Grey(context, snapshot.data.email),
                      WidgetUtil.heightBox5(),
                      WidgetUtil.textBody1Grey(context, snapshot.data.userID),
                      WidgetUtil.heightBox5(),
                      WidgetUtil.heightBox20(),
                      DashboardMenuRowThree(
                        firstIcon: Icons.group_work,
                        firstLabel: Const.myClubs,
                        firstOnPress:  _openMyClubs,
                        secondIcon: Icons.add,
                        secondLabel: Const.insertSchedule,
                        secondOnPress: () => {print('linhnt 222')},
                        thirdIcon: Icons.exit_to_app,
                        thirdLabel: Const.logout,
                        thirdOnPress: () => {_questionSignOut()},
                      ),
                      WidgetUtil.heightBox5(),
                      DashboardMenuRowThree(
                        firstIcon: Icons.access_time,
                        firstLabel: Const.watchSchedule,
                        firstOnPress: () => {print('linhnt 111')},
                        secondIcon: Icons.add,
                        secondLabel: Const.insertSchedule,
                        secondOnPress: () => {print('linhnt 222')},
                        thirdIcon: Icons.exit_to_app,
                        thirdLabel: Const.logout,
                        thirdOnPress: () => {_questionSignOut()},
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      );

  _signInSignUpScreen() => Scaffold(
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              WidgetUtil.showLogo(),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text(
                  Const.appName,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green[900],
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: Const.openSansFont,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: Const.openSansFont,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomFlatButton(
                    title: Const.signIn,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () => _buttonTapped(true),
                    splashColor: Colors.black12,
                    borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                    borderWidth: 0,
                    color: Colors.green[900],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomFlatButton(
                    title: Const.signUp,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black54,
                    onPressed: () => _buttonTapped(false),
                    splashColor: Colors.black12,
                    borderColor: Colors.black54,
                    borderWidth: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _openMyClubs() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyClubsScreen(userModel: userModel)),
    );
  }
}
