import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/listener/select_city_listener.dart';
import 'package:bongdaphui/listener/select_district_listener.dart';
import 'package:bongdaphui/listener/select_type_field_listener.dart';
import 'package:bongdaphui/models/city_model.dart';
import 'package:bongdaphui/models/district_model.dart';
import 'package:bongdaphui/ui/widgets/custom_text_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:bongdaphui/listener/select_time_listener.dart';


void main() {
  runApp(InsertSchedulePlayerScreen());
}

class InsertSchedulePlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InsertSchedulePlayerScreenState();
  }
}

class _InsertSchedulePlayerScreenState extends State<InsertSchedulePlayerScreen>
    implements
        InsertListener,
        SelectTypeFieldListener,
        SelectCityListener,
        SelectDistrictListener , SelectTimeListener{
  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _timeStart = new TextEditingController();
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

  _loadListCity() async {
    _listCity = await Util.loadCity();
    setState(() {
      _city = _listCity[0];
      _loadListDistrict(_city);
    });
  }

  _loadListDistrict(CityModel cityModel) async {
    _listDistrict = await Util.loadDistrict(cityModel.id);
    setState(() {
      _district = _listDistrict[0];
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

  @override
  void onInsert() {
    // TODO: implement onInsert
  }

  @override
  void onSelect(String time) {
   setState(() {
     _timeStart.text = time;
   });
  }

  @override
  void initState() {
    super.initState();

    _loadListCity();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullName,
      hint: Const.fullName,
      validator: Validator.validateName,
    );
    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _number,
      hint: Const.phoneNumber,
      validator: Validator.validateNumber,
      inputType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: WidgetUtil.appBar(Const.insertSchedulePlayer),
        body: Padding(
          padding: const EdgeInsets.all(Const.size_10),
          child: ListView(
            children: <Widget>[
              _nameField,
              WidgetUtil.sizeBox10(),
              _phoneField,
              WidgetUtil.sizeBox10(),
              WidgetUtil.textDes(context, Const.typeField),
              WidgetUtil.selectTypeField(context, _valueFivePeople,
                  _valueSevenPeople, _valueElevenPeople, this),
              WidgetUtil.sizeBox5(),
              WidgetUtil.textDes(context, Const.area),
              WidgetUtil.sizeBox5(),
              Card(
                elevation: 0.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[400], width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Util.filterBox(context, _listCity, _city, _listDistrict,
                    _district, this, this),
              ),
              WidgetUtil.sizeBox10(),
              WidgetUtil.textDes(context, Const.timeSlot),
              WidgetUtil.sizeBox10(),
              Text('Từ lúc'),
              Row(
                children: <Widget>[
                  Flexible(
                    child: CustomTextField(
                      baseColor: Colors.grey,
                      borderColor: Colors.grey[400],
                      errorColor: Colors.red,
                      controller: _timeStart,
                      hint: Const.timeSlotStart,
//                      validator: Validator.validateName,
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: WidgetUtil.buttonChangeTime( context,Const.choose, this),
                    flex: 1,
                  )
                ],
              ),
              WidgetUtil.buttonInsert(Const.insertSchedule, this),
            ],
          ),
        ),
      ),
    );
  }
}
