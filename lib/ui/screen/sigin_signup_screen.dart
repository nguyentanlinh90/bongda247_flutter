import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/widget_util.dart';
import 'package:flutter/material.dart';

class SignInSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(Const.signInRoute);
                  },
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(Const.signUpRoute);
                  },
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
  }
}
