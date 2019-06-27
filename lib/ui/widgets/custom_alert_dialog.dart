import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/widget.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressed;

  CustomAlertDialog({this.title, this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(Const.size_5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Const.size_32))),
      title: Text(
        title,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: Const.size_16,
          fontWeight: FontWeight.w700,
          fontFamily: Const.openSansFont,
        ),
      ),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            WidgetUtil.sizeBox10(),
            Text(
              content,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                decoration: TextDecoration.none,
                fontSize: Const.size_16,
                fontWeight: FontWeight.w300,
                fontFamily: Const.openSansFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Const.size_40, bottom: Const.size_10),
              child: CustomFlatButton(
                title: Const.close,
                fontSize: Const.size_16,
                fontWeight: FontWeight.w700,
                textColor: Colors.black54,
                onPressed: () {
                  Navigator.of(context).pop();
                  onPressed();
                },
                splashColor: Colors.black12,
                borderColor: Colors.black12,
                borderWidth: Const.size_2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
