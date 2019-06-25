import 'package:bongdaphui/business/validator.dart';
import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/ui/widgets/custom_text_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:bongdaphui/utils/widget_util.dart';
import 'package:flutter/material.dart';

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
    implements InsertListener {
  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _phoneField;
  VoidCallback onBackPress;

  @override
  void onInsert() {
    // TODO: implement onInsert
  }

  @override
  void initState() {
    super.initState();

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
              WidgetUtil.buttonInsert(Const.insertSchedule, this)
            ],
          ),
        ),
      ),
    );
  }
}
