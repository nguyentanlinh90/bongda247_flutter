import 'dart:io';

import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/business/fire_base.dart';
import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/handel/image_picker_handler.dart';
import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/club_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/ui/widgets/custom_text_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class InsertClubScreen extends StatefulWidget {
  InsertClubScreen({Key key, this.uid}) : super(key: key);
  final String uid;

  State<StatefulWidget> createState() {
    return _InsertClubScreenState();
  }
}

class _InsertClubScreenState extends State<InsertClubScreen>
    with
        TickerProviderStateMixin,
        ImagePickerListener,
        SelectCityListener,
        SelectDistrictListener {
  String uid;
  UserModel user;

  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _captainName = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  CustomTextField _captainField;

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String downloadUrlPic = '';
  bool _blackVisible = false;

  List<CityModel> _listCity = List();
  List<DistrictModel> _listDistrict = List();
  CityModel _city;
  DistrictModel _district;

  _loadListCity() async {
    _listCity = await Utils.loadCity();
    setState(() {
      _city = _listCity[0];
      _loadListDistrict(_city);
    });
  }

  _loadListDistrict(CityModel cityModel) async {
    _listDistrict = await Utils.loadDistrict(cityModel.id);
    setState(() {
      _district = _listDistrict[0];
    });
  }

  @override
  void onSelectCity(CityModel model) {
    setState(() {
      _city = model;
      _loadListDistrict(_city);
    });
  }

  @override
  void onSelectDistrict(DistrictModel model) {
    setState(() {
      _district = model;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadListCity();

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

    _captainField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _captainName,
      hint: Const.captainName,
      validator: Validator.validateEmpty,
    );
  }

  void _setUser(UserModel model) {
    user = model;
    if (user.phone.isNotEmpty) _phoneNumber.text = user.phone;
    if (user.fullName.isNotEmpty) _captainName.text = user.fullName;
  }

  @override
  Widget build(BuildContext context) {
    uid = ModalRoute.of(context).settings.arguments;

    void _changeBlackVisible() {
      setState(() {
        _blackVisible = !_blackVisible;
      });
    }

    void _pop() {
//      Navigator.pop(context);
      setState(() {
        _blackVisible = !_blackVisible;
      });
    }

    Future _insertClub(BuildContext context) async {
      if (Validator.validateName(_fullName.text) &&
          Validator.validateNumber(_phoneNumber.text)) {
        if (!Validator.validateDistrict(_district.id)) {
          WidgetUtil.showSnackBar(context, Const.notYetPlace);
          return;
        }
        if (null != _image) {
          //upload Image
          _changeBlackVisible();
          String fileName = basename(_image.path);
          StorageReference fireBaseStorageRef = FirebaseStorage.instance
              .ref()
              .child(Const.clubPath)
              .child(fileName);
          StorageUploadTask uploadTask = fireBaseStorageRef.putFile(_image);
          StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

          if (uploadTask.isComplete && uploadTask.isSuccessful) {
            downloadUrlPic = await taskSnapshot.ref.getDownloadURL();
          }
        }

        try {
          ClubModel clubModel = new ClubModel(
              id: Utils.generateId(),
              photo: downloadUrlPic,
              name: _fullName.text,
              captionName: _captainName.text,
              phone: _phoneNumber.text,
              idCity: _city.id,
              idDistrict: _district.id,
              user: user.toJson().toString());

          FireBase.addClub(clubModel).whenComplete(() {
            //add club to user model (update data)
            ClubModel clubModel = new ClubModel(
                id: Utils.generateId(),
                photo: downloadUrlPic,
                name: _fullName.text,
                captionName: _captainName.text,
                phone: _phoneNumber.text,
                idCity: _city.id,
                idDistrict: _district.id);

            Firestore.instance
                .collection(Const.usersCollection)
                .document(user.userID)
                .updateData({
              'clubs': FieldValue.arrayUnion([clubModel.toJson()])
            }).whenComplete(() {
              WidgetUtil.showAlert(
                context: context,
                title: Const.alert,
                content: Const.insertClubSuccess,
                onPressed: _pop,
              );
            });
          }).catchError((error) {
            WidgetUtil.showAlert(
              context: context,
              title: Const.alert,
              content: '${Const.insertClubFail}\nLỗi: ${error.toString()}',
              onPressed: _pop,
            );
          });
        } catch (e) {
          WidgetUtil.showAlert(
            context: context,
            title: Const.registerFail,
            content: '${Const.insertClubFail}\nLỗi: ${e.toString()}',
            onPressed: _pop,
          );
        }
      }
    }

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
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(Const.size_10),
                    child: ListView(
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
                                          backgroundColor:
                                              const Color(0xFF778899),
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
                        _captainField,
                        WidgetUtil.heightBox10(),
                        _phoneField,
                        WidgetUtil.heightBox10(),
                        WidgetUtil.textBody1Grey(context, Const.place),
                        WidgetUtil.heightBox5(),
                        Card(
                          elevation: 0.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: Colors.grey[400], width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Utils.filterBox(context, _listCity, _city,
                              _listDistrict, _district, this, this),
                        ),
                        WidgetUtil.heightBox20(),
                        Container(
                          width: Const.size_200,
                          child: CustomFlatButton(
                            title: Const.insert,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                            onPressed: () => _insertClub(context),
                            splashColor: Colors.black12,
                            borderColor: Colors.grey[900],
                            borderWidth: 0.0,
                            color: Colors.green[800],
                          ),
                        ),
                      ],
                    ),
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
                  )
                ],
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
