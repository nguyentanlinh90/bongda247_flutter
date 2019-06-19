import 'package:flutter/material.dart';

void main() => runApp(new Login());

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final blueGrey300 = const Color(0xff90A4AE);
    final blueGrey500 = const Color(0xff607D8B);
    final blueGrey900 = const Color(0xff263238);

    final green300 = const Color(0xff81C784);
    final green400 = const Color(0xff66BB6A);

    final deepOrangeA200 = const Color(0xffFF6E40);

    final c_3B5998 = const Color(0xff3B5998);

    final white = const Color(0xffffffff);

    Widget title = new Container(
      margin: const EdgeInsets.only(bottom: 25.0),
      child: new Text(
        "Bóng Đá Phủi",
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 25.0, color: white),
      ),
    );

    Widget title1 = new Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: new Text(
        "Tài khoản",
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 18.0, color: blueGrey500),
      ),
    );

    Widget etAccount = new Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: new TextFormField(
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 18.0, color: blueGrey500),
      ),
    );

    Widget title2 = new Container(
      margin: const EdgeInsets.only(top: 5.0),
      child: new Text(
        "Mật khẩu",
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 18.0, color: blueGrey500),
      ),
    );

    Widget etPass = new Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      child: new TextFormField(
        obscureText: true,
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 18.0, color: blueGrey500),
      ),
    );

    Widget forgetPass = new Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: new Text(
        "Quên mật khẩu?",
        textAlign: TextAlign.right,
        style: new TextStyle(fontSize: 20.0, color: blueGrey500),
      ),
    );

    Widget btLogin = new ButtonTheme(
      height: 55.0,
      child: new RaisedButton(
          child: new Text(
            "Đăng nhập",
            style: new TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          disabledColor: green400,
          onPressed: null,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0))),
    );

    Widget btFacebook = new Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      height: 55.0,
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: c_3B5998,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0))),
          child: new Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 30.0,
                  height: 30.0,
                  child: new Image.asset('images/ic_login_facebook.png'),
                ),
                new Text("Facebook",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white))
              ],
            ),
          )),
    );

    Widget btGoogle = new Container(
      height: 55.0,
      color: Colors.transparent,
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(const Radius.circular(30.0))),
          child: new Center(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 30.0,
                  height: 30.0,
                  child: new Image.asset('images/ic_login_google.png'),
                ),
                new Text("Google",
                    style: new TextStyle(fontSize: 18.0, color: Colors.black))
              ],
            ),
          )),
    );

    Widget viewRegister = new Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Thành viên mới?  ",
              style: new TextStyle(fontSize: 18.0, color: blueGrey300),
            ),
            new Text(
              "Đăng ký",
              style: new TextStyle(
                  fontSize: 18.0, color: green300, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );

    Widget later = new Center(
      child: new Text("Để sau",
          style: new TextStyle(
              fontSize: 18.0,
              color: deepOrangeA200,
              fontWeight: FontWeight.bold)),
    );

    return MaterialApp(
      title: "Bóng Đá Phủi",
      home: new Scaffold(
          backgroundColor: blueGrey900,
          body: new Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: new Center(
              child: new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  title,
                  title1,
                  etAccount,
                  title2,
                  etPass,
                  forgetPass,
                  btLogin,
                  btFacebook,
                  btGoogle,
                  viewRegister,
                  later
                ],
              ),
            ),
          )),
    );
  }
}
