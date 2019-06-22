import 'package:bongdaphui/models/tutorial.dart';
import 'package:bongdaphui/ui/widgets/custom_flat_button.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/shared_preferences.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:flutter/material.dart';
import "package:flutter_swiper/flutter_swiper.dart";

void main() => runApp(new TutorialScreen());

// ignore: must_be_immutable
class TutorialScreen extends StatelessWidget {
  final List<Tutorial> list;

  TutorialScreen({Key key, this.list}) : super(key: key);

//  @override
//  State<StatefulWidget> createState() => new _TutorialScreenState();
//}
//
//class _TutorialScreenState extends State<TutorialScreen> {
  Size deviceSize;

  List<Widget> _getPages(BuildContext context) {
    List<Tutorial> pages = list;
    List<Widget> widgets = [];
    for (int i = 0; i < pages.length; i++) {
      Tutorial page = pages[i];

      widgets.add(new Container(
        padding: const EdgeInsets.only(bottom: Const.size_30),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
          colors: Const.kitGradients,
        )),
        child: Column(
          children: <Widget>[
            Container(
              height: deviceSize.height * 0.7,
              padding: EdgeInsets.only(top: Const.size_20),
              child: new Stack(
                children: <Widget>[
                  Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white))),
                  Center(child: Image.network(page.photo))
                ],
              ),
            ),
            Container(
                height: deviceSize.height * 0.07,
                padding:
                    EdgeInsets.only(left: Const.size_20, right: Const.size_20),
                child: Center(
                    child: Text(
                  page.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: Const.openSans,
                  ),
                ))),
            Container(
              padding:
                  EdgeInsets.only(left: Const.size_20, right: Const.size_20),
              child: Text(
                page.content,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: Const.size_15,
                  fontWeight: FontWeight.w300,
                  fontFamily: Const.openSans,
                ),
              ),
            )
          ],
        ),
      ));
    }

    widgets.add(
      new Container(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
          colors: Const.kitGradients,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Util.showLogo(),
              Padding(
                padding: const EdgeInsets.only(
                    top: Const.size_20,
                    right: Const.size_15,
                    left: Const.size_15),
                child: CustomFlatButton(
                  title: Const.start,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  onPressed: () {
                    SharedPreferencesUtil.setSeenTutorialPrefs(true);
                    Navigator.of(context).pushNamed(Const.mainRoute);
                  },
                  splashColor: Colors.black12,
                  borderColor: Colors.white,
                  borderWidth: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return new Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        body: SafeArea(
            child: Swiper.children(
          autoplay: false,
          index: 0,
          loop: false,
          pagination: new SwiperPagination(
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
            builder: new DotSwiperPaginationBuilder(
                color: Colors.white30,
                activeColor: Colors.white,
                size: 6.5,
                activeSize: 8.0),
          ),
          control: SwiperControl(
            iconPrevious: null,
            iconNext: null,
          ),
          children: _getPages(context),
        )),
      ),
    );
  }
}
