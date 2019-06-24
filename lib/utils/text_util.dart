import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

class TextUtil {
  static Widget textTitle(BuildContext context, String text) => Text(text,
      style: Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 700));

  static Widget textContent(BuildContext context, String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.green[900]));

  static Widget textDes(BuildContext context, String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.grey[900]));
}
