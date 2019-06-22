import 'package:bmnav/bmnav.dart';
import 'package:bongdaphui/tabs/account_tab.dart';
import 'package:bongdaphui/tabs/clubs_tab.dart';
import 'package:bongdaphui/tabs/fields_tab.dart';
import 'package:bongdaphui/tabs/find_clubs_tab.dart';
import 'package:bongdaphui/tabs/find_players_tab.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      // Title
      title: "Using Tabs",
      // Home
      home: new HomeScreen()));
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

// SingleTickerProviderStateMixin is used for animation
class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> tabs = [
    FieldsTab(),
    FindPlayersTab(),
    FindClubsTab(),
    ClubsTab(),
    AccountTab()
  ];
  Widget currentTabs = FieldsTab();

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
    return new Scaffold(
      // Set the TabBar view as the body of the Scaffold
      /*body: new TabBarView(
        // Add tabs as widgets
        children: <Widget>[
          new FieldsTab(),
          new FindClubsTab(),
          new FindPlayersTab(),
          new ClubsTab(),
          new AccountTab()
        ],
        // set the controller
        controller: controller,
      )*/
      body: PageStorage(child: currentTabs, bucket: bucket),
      bottomNavigationBar: BottomNav(
        labelStyle: LabelStyle(
            showOnSelect: true,
            onSelectTextStyle: TextStyle(color: Colors.white)),
        iconStyle: IconStyle(
            onSelectSize: Const.size_30,
            color: Colors.white,
            onSelectColor: Colors.yellow),
        color: Colors.green[900],
        index: currentTab,
        onTap: (i) {
          setState(() {
            currentTab = i;
            currentTabs = tabs[i];
          });
        },
        items: [
          BottomNavItem(Icons.widgets, label: 'Tìm sân'),
          BottomNavItem(Icons.group, label: 'Tìm người'),
          BottomNavItem(Icons.group_work, label: 'Tìm đội'),
          BottomNavItem(Icons.location_searching, label: 'Đội bóng'),
          BottomNavItem(Icons.account_circle, label: 'Tài khoản')
        ],
      )
      // Set the bottom navigation bar
      /*bottomNavigationBar: new Material(
        // set the color of the bottom navigation bar
        color: Colors.green[900],
        // set the tab bar as the child of bottom navigation bar
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.favorite),
            ),
            new Tab(
              icon: new Icon(Icons.adb),
            ),
            new Tab(
              icon: new Icon(Icons.airport_shuttle),
            ),
            new Tab(
              icon: new Icon(Icons.find_in_page),
            ),
            new Tab(
              icon: new Icon(Icons.search),
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      )*/
      ,
    );
  }
}
