import 'package:bongdaphui/business/auth.dart';
import 'package:bongdaphui/business/fire_base.dart';
import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/listener/select_time_end_listener.dart';
import 'package:bongdaphui/listener/select_time_start_listener.dart';
import 'package:bongdaphui/listener/select_type_field_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/models/match_model.dart';
import 'package:bongdaphui/models/screen_arguments.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/ui/widgets/custom_text_field.dart';
import 'package:bongdaphui/ui/widgets/date_time_picker.dart';
import 'package:bongdaphui/utils/Enum.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/date_time.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';

class InsertMatchScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _InsertMatchScreenState();
  }
}

class _InsertMatchScreenState extends State<InsertMatchScreen>
    implements
        InsertListener,
        SelectTypeFieldListener,
        SelectCityListener,
        SelectDistrictListener,
        SelectTimeStartListener,
        SelectTimeEndListener {
  ScreenArguments args;

  UserModel user;

  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _timeStart = new TextEditingController();
  final TextEditingController _timeEnd = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  VoidCallback onBackPress;
  bool _valueFivePeople = true;
  bool _valueSevenPeople = true;
  bool _valueElevenPeople = true;

  List<CityModel> _listCity = List();
  List<DistrictModel> _listDistrict = List();
  CityModel _city;
  DistrictModel _district;

  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = TimeOfDay.now();

  DateTime _toDate = DateTime.now();
  TimeOfDay _toTime =
      TimeOfDay(hour: DateTime.now().hour + 2, minute: DateTime.now().minute);

  _getArgs(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullName,
      hint: args.typeMatch == EnumTypeMatch.player.toString()
          ? Const.yourName
          : Const.nameClub,
      validator: Validator.validateName,
    );
  }

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
  void initState() {
    super.initState();
    _loadListCity();

    onBackPress = () {
      Navigator.of(context).pop();
    };

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
  void onTimeStartSelect(String time) {
    setState(() {
      _timeStart.text = time;
    });
  }

  @override
  void onTimeEndSelect(String time) {
    setState(() {
      _timeEnd.text = time;
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
  void onFive(bool value) {
    setState(() {
      _valueFivePeople = value;
    });
  }

  @override
  void onSeven(bool value) {
    setState(() {
      _valueSevenPeople = value;
    });
  }

  @override
  void onEleven(bool value) {
    setState(() {
      _valueElevenPeople = value;
    });
  }

  bool _validateTime(int from, int to) {
    return to - from >= 7200000; // 2 hours = 2 * 3600000 (ms)
  }

  @override
  void onInsert() {
    int from =
        DateTimeUtil.toMillisecondsSinceEpoch(context, _fromDate, _fromTime);
    int to = DateTimeUtil.toMillisecondsSinceEpoch(context, _toDate, _toTime);

    if (!_validateTime(from, to)) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              title: Const.alert,
              content: Const.timeNotValid,
              rightText: Const.close,
            );
          });
    } else {
      String id =
          '${DateTime.now().millisecondsSinceEpoch}${Utils.randomString(4)}';

      String typeField = '';
      if (_valueFivePeople)
        typeField = typeField + EnumTypeField.field5.toString();
      if (_valueSevenPeople)
        typeField = typeField + EnumTypeField.field7.toString();
      if (_valueElevenPeople)
        typeField = typeField + EnumTypeField.field11.toString();

      MatchModel matchModel = MatchModel(
          id,
          args.idUser,
          args.typeMatch,
          typeField,
          _city.id,
          _district.id,
          '$from',
          '$to',
          _fullName.text,
          _phoneNumber.text,
          user.profilePictureURL.isEmpty ? '' : user.profilePictureURL);
      try {
        FireBase.addMatch(matchModel).whenComplete(() {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  title: Const.alert,
                  content: Const.insertMatchSuccess,
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
  }

  _widgetTimeFrom() => DateTimePicker(
        labelText: Const.from,
        firstDate: _fromDate,
        selectedDate: _fromDate,
        selectedTime: _fromTime,
        selectDate: (DateTime date) {
          setState(() {
            _fromDate = date;
            if (_toDate.millisecondsSinceEpoch <
                _fromDate.millisecondsSinceEpoch) {
              _toDate = _fromDate;
            }
          });
        },
        selectTime: (TimeOfDay time) {
          setState(() {
            _fromTime = time;
          });
        },
      );

  _widgetTimeTo() => DateTimePicker(
        labelText: Const.to,
        firstDate: _fromDate,
        selectedDate: _toDate,
        selectedTime: _toTime,
        selectDate: (DateTime date) {
          setState(() {
            _toDate = date;
          });
        },
        selectTime: (TimeOfDay time) {
          setState(() {
            _toTime = time;
          });
        },
      );

  void _setUser(UserModel model) {
    user = model;
    if (args.typeMatch == EnumTypeMatch.player.toString()) {
      if (user.fullName.isNotEmpty) _fullName.text = user.fullName;
    }
    if (user.phone.isNotEmpty) _phoneNumber.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    _getArgs(context);

    return SafeArea(
      child: Scaffold(
        appBar: WidgetUtil.appBar(Const.insertSchedulePlayer),
        body: StreamBuilder(
          stream: Auth.getUser(args.idUser),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (!snapshot.hasData) {
              WidgetUtil.progress();
            } else {
              _setUser(snapshot.data);
              return Padding(
                padding: const EdgeInsets.all(Const.size_10),
                child: ListView(
                  children: <Widget>[
                    _nameField,
                    WidgetUtil.heightBox10(),
                    _phoneField,
                    WidgetUtil.heightBox10(),
                    WidgetUtil.textBody1Grey(context, Const.timeSlot),
                    WidgetUtil.heightBox5(),
                    _widgetTimeFrom(),
                    _widgetTimeTo(),
                    WidgetUtil.heightBox10(),
                    WidgetUtil.textBody1Grey(context, Const.area),
                    WidgetUtil.heightBox5(),
                    Card(
                      elevation: 0.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[400], width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Utils.filterBox(context, _listCity, _city,
                          _listDistrict, _district, this, this),
                    ),
                    WidgetUtil.heightBox10(),
                    WidgetUtil.textBody1Grey(context, Const.typeField),
                    WidgetUtil.selectTypeField(context, _valueFivePeople,
                        _valueSevenPeople, _valueElevenPeople, this),
                    WidgetUtil.heightBox20(),
                    WidgetUtil.buttonInsert(Const.insert, this),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
