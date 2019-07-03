import 'package:bmnav/bmnav.dart';
import 'package:bongdaphui/tabs/account_tab.dart';
import 'package:bongdaphui/tabs/clubs_tab.dart';
import 'package:bongdaphui/tabs/fields_tab.dart';
import 'package:bongdaphui/tabs/match_tab.dart';
import 'package:bongdaphui/utils/Enum.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => new _MainScreenState();
}

// SingleTickerProviderStateMixin is used for animation
class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;
  int currentPosTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> tabs = [
    FieldsTab(),
    MatchTab(typeMatch: EnumTypeMatch.player.toString()),
    MatchTab(typeMatch: EnumTypeMatch.club.toString()),
    ClubsTab(),
    AccountTab()
  ];
  Widget currentScreenTabs = FieldsTab();

  @override
  void initState() {
    super.initState();
    // Initialize the Tab Controller
    controller = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() => Scaffold(
      body: PageStorage(child: currentScreenTabs, bucket: bucket),
      bottomNavigationBar: BottomNav(
        labelStyle: LabelStyle(
            showOnSelect: true,
            onSelectTextStyle: TextStyle(color: Colors.white)),
        iconStyle: IconStyle(
            onSelectSize: Const.size_30,
            color: Colors.white,
            onSelectColor: Colors.yellow),
        color: Colors.green[900],
        index: currentPosTab,
        onTap: (i) {
          setState(() {
            currentPosTab = i;
            currentScreenTabs = tabs[i];
          });
        },
        items: [
          BottomNavItem(Icons.widgets, label: 'Tìm sân'),
          BottomNavItem(Icons.group, label: 'Tìm người'),
          BottomNavItem(Icons.group_work, label: 'Tìm đội'),
          BottomNavItem(Icons.location_searching, label: 'Đội bóng'),
          BottomNavItem(Icons.account_circle, label: 'Tài khoản')
        ],
      ));
}
