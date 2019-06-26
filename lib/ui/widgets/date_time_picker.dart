import 'package:bongdaphui/ui/widgets/input_dropdown.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/date_time.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.subhead.apply(
        fontFamily: Const.ralewayFont,
        color: Colors.grey[900],
        fontWeightDelta: 2);

    return Row(
      children: <Widget>[
        SizedBox(
            width: Const.size_40,
            child: WidgetUtil.textBody1Grey(context, labelText)),
        Expanded(
          child: Card(
              elevation: 0.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[400]),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SizedBox(
                width: double.infinity,
                height: Const.size_50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Const.size_10),
                        child: InputDropdown(
//            labelText: labelText,
                          valueText:
                              '${DateTimeUtil.getDayOfWeek(selectedDate)},  ${DateFormat(FormatDate.ddMMyyyy.toString()).format(selectedDate)}',
                          valueStyle: valueStyle,
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.5,
                      height: Const.size_50,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Const.size_10),
                        child: InputDropdown(
//            valueText: selectedTime.format(context),
                          valueText: selectedTime.format(context),
                          valueStyle: valueStyle,
                          onPressed: () {
                            _selectTime(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
