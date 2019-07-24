import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/listener/select_time_end_listener.dart';
import 'package:bongdaphui/listener/select_time_start_listener.dart';
import 'package:bongdaphui/listener/select_type_field_listener.dart';
import 'package:bongdaphui/models/city.dart';
import 'package:bongdaphui/models/club.dart';
import 'package:bongdaphui/ui/widgets/custom_alert_dialog.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/utils/Enum.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:flutter/material.dart';

class WidgetUtil {
  static Widget showLogo() =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Container(
          width: 200,
          height: 200,
          child: new Image.asset(Const.icSplash),
        )
      ]);

  static Widget appBar(String title) => AppBar(
        elevation: 2.0,
        iconTheme: IconThemeData(color: Colors.grey[900]),
        backgroundColor: Colors.green[100],
        title: Text(title,
            softWrap: true,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.grey[900],
              decoration: TextDecoration.none,
              fontSize: Const.size_20,
              fontWeight: FontWeight.w700,
              fontFamily: Const.openSansFont,
            )),
      );

  static Widget buttonInsert(String title, InsertListener listener) =>
      CustomFlatButton(
        title: title,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        textColor: Colors.white,
        onPressed: () => listener.onInsert(),
        splashColor: Colors.black12,
        borderColor: Colors.grey[900],
        borderWidth: 0.0,
        color: Colors.green[800],
      );

  static Widget buttonSelectStartTime(BuildContext context, String title,
          SelectTimeStartListener listener) =>
      CustomFlatButton(
        title: title,
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        textColor: Colors.white,
        onPressed: () => _selectStartDate(context, listener),
        splashColor: Colors.black12,
        borderColor: Colors.grey[900],
        borderWidth: 0.0,
        color: Colors.green[800],
      );

  static Future _selectStartDate(
      BuildContext context, SelectTimeStartListener listener) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 30)),
        lastDate: new DateTime.now().add(new Duration(days: 30)));
    if (picked != null) listener.onTimeStartSelect(picked.toString());
  }

  static Widget buttonSelectEndTime(
          BuildContext context, String title, SelectTimeEndListener listener) =>
      CustomFlatButton(
        title: title,
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        textColor: Colors.white,
        onPressed: () => _selectEndDate(context, listener),
        splashColor: Colors.black12,
        borderColor: Colors.grey[900],
        borderWidth: 0.0,
        color: Colors.green[800],
      );

  static Future _selectEndDate(
      BuildContext context, SelectTimeEndListener listener) async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
    if (picked != null) listener.onTimeEndSelect(picked.toString());
  }

  static Widget heightBox20() => SizedBox(height: Const.size_20);

  static Widget heightBox10() => SizedBox(height: Const.size_10);

  static Widget heightBox5() => SizedBox(height: Const.size_5);

  static Widget widthBox10() => SizedBox(width: Const.size_10);

  static Widget dividerGrey() => SizedBox(
        height: 0.5,
        width: double.infinity,
        child: const DecoratedBox(
          decoration: const BoxDecoration(color: Colors.grey),
        ),
      );

  static Widget showViewNoData(BuildContext context) => Center(
        child: Text(Const.noData,
            style: Theme.of(context)
                .textTheme
                .body1
                .apply(fontFamily: Const.ralewayFont, color: Colors.grey[900])),
      );

  static Widget textTitle(BuildContext context, String text) => Text(text,
      style: Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 700));

  static Widget textContent(BuildContext context, String text) => Text(text,
      style: Theme.of(context).textTheme.subhead.apply(
          fontFamily: Const.ralewayFont,
          color: Colors.green[900],
          fontWeightDelta: 2));

  static Widget textBody1Grey(BuildContext context, String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.grey[900]));

  static Widget textBody1Red(BuildContext context, String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.red[900]));

  static Widget selectTypeField(
          BuildContext context,
          bool fivePeople,
          bool sevenPeople,
          bool elevenPeople,
          SelectTypeFieldListener listener) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                onChanged: (value) {
                  listener.onFive(value);
                },
                value: fivePeople,
                activeColor: Colors.green[900],
              ),
              textContent(context, Const.fivePeoPle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                onChanged: (value) {
                  listener.onSeven(value);
                },
                value: sevenPeople,
                activeColor: Colors.green[900],
              ),
              textContent(context, Const.sevenPeoPle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Checkbox(
                onChanged: (value) {
                  listener.onEleven(value);
                },
                value: elevenPeople,
                activeColor: Colors.green[900],
              ),
              textContent(context, Const.elevenPeoPle),
            ],
          ),
        ],
      );

  static Widget buildTypeField(BuildContext context, String types) => Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            textContent(context, EnumTypeField.field5.toString()),
            Checkbox(
              onChanged: (value) {},
              value: types.contains(EnumTypeField.field5.toString())
                  ? true
                  : false,
              activeColor: Colors.green[900],
            ),
            widthBox10(),
            textContent(context, EnumTypeField.field7.toString()),
            Checkbox(
              onChanged: (value) {},
              value: types.contains(EnumTypeField.field7.toString())
                  ? true
                  : false,
              activeColor: Colors.green[900],
            ),
            widthBox10(),
            textContent(context, EnumTypeField.field11.toString()),
            Checkbox(
              onChanged: (value) {},
              value: types.contains(EnumTypeField.field11.toString())
                  ? true
                  : false,
              activeColor: Colors.green[900],
            ),
          ],
        ),
      );

  static Widget progress() => Container(
        child: Center(child: CircularProgressIndicator()),
        color: Colors.white,
      );

  static void showSnackBar(BuildContext context, String content) =>
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(content)));

  static void showAlert(
      {BuildContext context,
      String title,
      String content,
      VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          rightText: Const.close,
          content: content,
          title: title,
          rightOnPressed: onPressed,
        );
      },
    );
  }

  static Widget fillCardClub(BuildContext context, ClubModel model, List<CityModel> _listCity) => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: Const.size_60,
            height: Const.size_60,
            child: CircleAvatar(
                backgroundColor: Colors.green[900],
                backgroundImage: model.photo.isEmpty
                    ? AssetImage(Const.icPlaying)
                    : NetworkImage(model.photo)),
          ),
          SizedBox(
            height: Const.size_10,
          ),
          IconButton(
            icon: Icon(
              Icons.phone,
              color: Colors.green[900],
              size: Const.size_35,
            ),
            onPressed: () {
              Utils.callPhone(model.phone);
            },
          ),
        ],
      ),
      Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                WidgetUtil.textTitle(context, model.name),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.captain),
                    WidgetUtil.textContent(context, model.captionName)
                  ],
                  verticalDirection: VerticalDirection.up,
                ),
                SizedBox(
                  height: Const.size_5,
                ),
                Row(
                  children: <Widget>[
                    WidgetUtil.textBody1Grey(context, Const.area),
                    Utils.getArea(
                        context, _listCity, model.idCity, model.idDistrict)
                  ],
                ),
                SizedBox(
                  height: Const.size_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(context, model.phone),
                        WidgetUtil.textBody1Grey(context, Const.contact)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WidgetUtil.textContent(context, ''),
                        WidgetUtil.textBody1Grey(context, '')
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
    ],
  );

  static Widget postCardClub(BuildContext context, ClubModel model, List<CityModel> _listCity) => Card(
    margin: const EdgeInsets.only(
        left: Const.size_8, right: Const.size_8, bottom: Const.size_8),
    elevation: 2.0,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(Const.size_8),
          child: fillCardClub(context, model, _listCity),
        ),
        SizedBox(
          height: Const.size_5,
        ),
      ],
    ),
  );
}
