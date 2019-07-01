import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

import 'label_below_icon.dart';

class DashboardMenuRowThree extends StatelessWidget {
  final firstLabel;
  final IconData firstIcon;
  final GestureTapCallback firstOnPress;
  final secondLabel;
  final IconData secondIcon;
  final GestureTapCallback secondOnPress;
  final thirdLabel;
  final IconData thirdIcon;
  final GestureTapCallback thirdOnPress;

  DashboardMenuRowThree({
    this.firstLabel,
    this.firstIcon,
    this.firstOnPress,
    this.secondLabel,
    this.secondIcon,
    this.secondOnPress,
    this.thirdLabel,
    this.thirdIcon,
    this.thirdOnPress,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: firstOnPress,
            child: SizedBox.fromSize(
              size: Size.square(deviceSize.width / 3.3),
              child: Card(
                color: Colors.grey.shade300,
                child: LabelBelowIcon(
                  betweenHeight: Const.size_15,
                  icon: firstIcon,
                  label: firstLabel,
                  iconColor: Colors.green[900],
                  isCircleEnabled: false,
                ),
              ),
            ),
          ),
          GestureDetector(
              onTap: secondOnPress,
              child: SizedBox.fromSize(
                size: Size.square(deviceSize.width / 3.3),
                child: Card(
                  color: Colors.grey.shade300,
                  child: LabelBelowIcon(
                    betweenHeight: Const.size_15,
                    icon: secondIcon,
                    label: secondLabel,
                    iconColor: Colors.green[900],
                    isCircleEnabled: false,
                  ),
                ),
              )),
          GestureDetector(
            onTap: thirdOnPress,
            child: SizedBox.fromSize(
              size: Size.square(deviceSize.width / 3.3),
              child: Card(
                color: Colors.grey.shade300,
                child: LabelBelowIcon(
                  betweenHeight: Const.size_15,
                  icon: thirdIcon,
                  label: thirdLabel,
                  iconColor: Colors.green[900],
                  isCircleEnabled: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
