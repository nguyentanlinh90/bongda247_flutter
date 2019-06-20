import 'package:bongdaphui/services/authentication.dart';
import 'package:flutter/material.dart';

void main() => runApp(new LoginSignUpPage());

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginScreenState();
}

enum FormMode { LOGIN, SIGN_UP }

class _LoginScreenState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  TextEditingController passController = new TextEditingController();
  String _password;
  String _confirmPassword;
  String _errorMessage;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  final blueGrey300 = const Color(0xff90A4AE);
  final blueGrey500 = const Color(0xff607D8B);
  final blueGrey900 = const Color(0xff263238);

  final green300 = const Color(0xff81C784);
  final green400 = const Color(0xff66BB6A);

  final deepOrangeA200 = const Color(0xffFF6E40);

  final c_3B5998 = const Color(0xff3B5998);

  final white = const Color(0xffffffff);

  // Check if form is valid before perform login
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = '';
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
//          widget.auth.sendEmailVerification();
//          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && userId.length > 0) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = '';
    _isLoading = false;
    super.initState();
  }

  void _changeForm(bool isLogin) {
    _formKey.currentState.reset();
    _errorMessage = '';
    setState(() {
      _formMode = isLogin ? FormMode.LOGIN : FormMode.SIGN_UP;
    });
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Xác thực tài khoản của bạn'),
          content: new Text(
              'Liên kết để xác minh tài khoản đã được gửi đến email của bạn'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Đóng'),
              onPressed: () {
                _changeForm(true);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showLogo() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            width: 100.0,
            height: 100.0,
            child: new Image.asset('images/ic_launcher.png'),
          )
        ]);
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Email không được trống';
          }
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        controller: passController,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Mật khẩu',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
//              return 'Email can\'t be empty';
            return 'Mật khẩu không được trống';
          } else if (value.length < 6) {
            setState(() {
              _isLoading = false;
            });
//              return 'Email can\'t be empty';
            return 'Mật khẩu phải lớn hơn 6 ký tự';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showConfirmPasswordInput() {
    if (_formMode == FormMode.SIGN_UP) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
        child: new TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: new InputDecoration(
              hintText: 'Xác nhận mật khẩu',
              icon: new Icon(
                Icons.lock,
                color: Colors.grey,
              )),
          validator: (value) {
            if (value.isEmpty) {
              setState(() {
                _isLoading = false;
              });
//              return 'Email can\'t be empty';
              return 'Xác nhận mật khẩu không được trống';
            } else if (value != passController.text) {
              setState(() {
                _isLoading = false;
              });
              return 'Xác nhận mật khẩu không đúng';
            }
          },
          onSaved: (value) => _confirmPassword = value,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _showForgetPass() {
    if (_formMode == FormMode.LOGIN) {
      return new Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: new Text(
          'Quên mật khẩu?',
          textAlign: TextAlign.right,
          style: new TextStyle(fontSize: 18.0, color: blueGrey500),
        ),
      );
    } else {
      return new Container();
    }
  }

  Widget _showLoginButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: green400,
            child: new Text(
                _formMode == FormMode.LOGIN ? 'Đăng nhập' : 'Đăng ký',
                style: new TextStyle(fontSize: 18.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _showFacebookButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: c_3B5998,
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
                new Text('Facebook',
                    style: new TextStyle(fontSize: 18.0, color: Colors.white))
              ],
            ),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _showGoogleButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  width: 25.0,
                  height: 25.0,
                  child: new Image.asset('images/ic_login_google.png'),
                ),
                new Text('Google',
                    style: new TextStyle(fontSize: 18.0, color: Colors.black))
              ],
            ),
            onPressed: _validateAndSubmit,
          ),
        ));
  }

  Widget _showRegister() {
    return new Container(
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: new Center(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              _formMode == FormMode.LOGIN
                  ? 'Thành viên mới?  '
                  : 'Bạn có tài khoản?  ',
              style: new TextStyle(fontSize: 18.0, color: blueGrey300),
            ),
            new GestureDetector(
              onTap: () {
                _changeForm(_formMode == FormMode.LOGIN ? false : true);
              },
              child: new Text(
                _formMode == FormMode.LOGIN ? 'Đăng ký' : 'Đăng nhập',
                style: new TextStyle(
                    fontSize: 18.0,
                    color: green300,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showLater() {
    return new Center(
      child: new Text('Để sau',
          style: new TextStyle(
              fontSize: 18.0,
              color: deepOrangeA200,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showConfirmPasswordInput(),
              _showForgetPass(),
              _showErrorMessage(),
              _showLoginButton(),
              _showFacebookButton(),
              _showGoogleButton(),
              _showRegister(),
              _showLater()
            ],
          ),
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        _showBody(),
        _showCircularProgress(),
      ],
    ));
  }
}
