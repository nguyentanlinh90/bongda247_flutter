import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import "package:bongdaphui/ui/widgets/custom_text_field.dart";
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: Const.emailAddress,
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: Const.password,
      validator: Validator.validatePassword,
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Const.size_70,
                          bottom: Const.size_10,
                          left: Const.size_10,
                          right: Const.size_10),
                      child: Text(
                        Const.signIn,
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.green[900],
                          decoration: TextDecoration.none,
                          fontSize: Const.size_24,
                          fontWeight: FontWeight.w700,
                          fontFamily: Const.openSansFont,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Const.size_20,
                          bottom: Const.size_10,
                          left: Const.size_15,
                          right: Const.size_15),
                      child: _emailField,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: Const.size_10,
                          bottom: Const.size_20,
                          left: Const.size_15,
                          right: Const.size_15),
                      child: _passwordField,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Const.size_14, horizontal: Const.size_40),
                      child: CustomFlatButton(
                        title: Const.signIn,
                        fontSize: Const.size_22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _emailLogin(
                              email: _email.text,
                              password: _password.text,
                              context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                        borderWidth: 0,
                        color: Colors.green[900],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Const.size_10),
                      child: Text(
                        Const.or,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: Const.size_15,
                          fontWeight: FontWeight.w300,
                          fontFamily: Const.openSansFont,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Const.size_14, horizontal: Const.size_40),
                      child: CustomFlatButton(
                        title: Const.signInWithGoogle,
                        fontSize: Const.size_22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _googleLogin(context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                        borderWidth: 0,
                        color: Colors.red[500],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Const.size_14, horizontal: Const.size_40),
                      child: CustomFlatButton(
                        title: Const.signInWithFacebook,
                        fontSize: Const.size_22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          _facebookLogin(context: context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                        borderWidth: 0,
                        color: Colors.blue[900],
                      ),
                    )
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signIn(email, password)
            .then((uid) => Utils.popDataSignIn(context));
      } catch (e) {
        print("Error in email sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: Const.loginFail,
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _facebookLogin({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult result = await facebookLogin
          .logInWithReadPermissions(['email', 'public_profile']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential fbCredential = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);
          await FirebaseAuth.instance
              .signInWithCredential(fbCredential)
              .then((FirebaseUser fireBaseUser) {
            User user = new User(
              fullName: fireBaseUser.displayName,
              userID: fireBaseUser.uid,
              email: fireBaseUser.email ?? '',
              phone: fireBaseUser.phoneNumber ?? '',
              profilePictureURL: fireBaseUser.photoUrl ?? '',
            );
            Auth.addUser(user);
            Utils.popDataSignIn(context);
          });

          break;
        case FacebookLoginStatus.cancelledByUser:
        case FacebookLoginStatus.error:
          _changeBlackVisible();
      }
    } catch (e) {
      print("Error in facebook sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: Const.loginFail,
        content: exception,
        onPressed: _changeBlackVisible,
      );
    }
  }

  void _googleLogin({BuildContext context}) async {
    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();

      final GoogleSignIn _googleSignIn = GoogleSignIn();

      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser fireBaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User user = new User(
        fullName: fireBaseUser.displayName,
        userID: fireBaseUser.uid,
        email: fireBaseUser.email ?? '',
        profilePictureURL: fireBaseUser.photoUrl ?? '',
      );
      Auth.addUser(user);
      Utils.popDataSignIn(context);
    } catch (e) {
      print("Error in google sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: Const.loginFail,
        content: exception,
        onPressed: _changeBlackVisible,
      );
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          rightText: Const.close,
          rightOnPressed: onPressed,
        );
      },
    );
  }
}
