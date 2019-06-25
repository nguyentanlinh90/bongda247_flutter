import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/utils/const.dart';
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

  static Widget sizeBox10() =>
      SizedBox(width: double.infinity, height: Const.size_10);

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
}
