import 'dart:io';

import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/business/fire_base.dart';
import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/handel/image_picker_handler.dart';
import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/models/club_model.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/ui/widgets/custom_text_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';

class InsertClubScreen extends StatefulWidget {
  InsertClubScreen({Key key, this.uid}) : super(key: key);
  final String uid;

  State<StatefulWidget> createState() {
    return _InsertClubScreenState();
  }
}

class _InsertClubScreenState extends State<InsertClubScreen>
    with TickerProviderStateMixin, ImagePickerListener, InsertListener {
  String uid;
  UserModel user;

  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  VoidCallback onBackPress;

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullName,
      hint: Const.nameClub,
      validator: Validator.validateName,
    );

    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _phoneNumber,
      hint: Const.phoneNumber,
      validator: Validator.validateNumber,
      inputType: TextInputType.number,
    );
  }

  @override
  void onInsert() {
    ClubModel clubModel;
    try {
      FireBase.addClub(clubModel).whenComplete(() {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: Const.alert,
                content: Const.insertClubSuccess,
                rightText: Const.close,
              );
            });
      }).catchError((error) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: Const.alert,
                content: '${Const.insertMatchFail}\nLỗi: ${error.toString()}',
                rightText: Const.close,
              );
            });
      });
    } catch (e) {
      print('linhnt${e.toString()}');
    }
  }

  void _setUser(UserModel model) {
    user = model;
  }

  @override
  Widget build(BuildContext context) {
    uid = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: WidgetUtil.appBar(Const.insertClub),
        body: StreamBuilder(
          stream: Auth.getUser(widget.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (!snapshot.hasData) {
              WidgetUtil.progress();
            } else {
              _setUser(snapshot.data);
              return Padding(
                padding: const EdgeInsets.all(Const.size_10),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => imagePicker.showDialog(context),
                      child: Center(
                        child: _image == null
                            ? Stack(
                                children: <Widget>[
                                  Center(
                                    child: new CircleAvatar(
                                      radius: Const.size_80,
                                      backgroundColor: const Color(0xFF778899),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      width: Const.size_160,
                                      height: Const.size_160,
                                      child: Padding(
                                        padding: const EdgeInsets.all(40),
                                        child: Image.asset(Const.icCamera),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : new Container(
                                height: Const.size_160,
                                width: Const.size_160,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: new ExactAssetImage(_image.path),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.green[900],
                                      width: Const.size_2),
                                  borderRadius: new BorderRadius.all(
                                      const Radius.circular(Const.size_80)),
                                ),
                              ),
                      ),
                    ),
                    WidgetUtil.heightBox10(),
                    _nameField,
                    WidgetUtil.heightBox10(),
                    _phoneField,
                    WidgetUtil.heightBox20(),
                    Container(
                      width: Const.size_200,
                      child: WidgetUtil.buttonInsert(Const.insert, this),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
