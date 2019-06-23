import 'package:bongdaphui/logic/bloc/field_bloc.dart';
import 'package:bongdaphui/models/soccer_field.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/utils/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FieldsTab());
}

class FieldsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FieldsTabState();
  }
}

List<SoccerField> getList(AsyncSnapshot dataSnapshot) {
  List<SoccerField> list = new List();

  for (var value in dataSnapshot.data.documents) {
    list.add(new SoccerField.fromJson(value));
  }
  return list;
}

class _FieldsTabState extends State<FieldsTab> {
  selectPhone(BuildContext context, String phone1, String phone2) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: textContent(Const.selectPhone),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  child: textTitle(phone1),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Util.callPhone(phone1);
                  },
                ),
                FlatButton(
                  child: textTitle(phone2),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Util.callPhone(phone2);
                  },
                )
              ],
            ));
      },
    );
  }

  priceAVG(String price, String priceMax) {
    String count = Const.threeDot;
    if (price.isNotEmpty && price.isEmpty) count = price;
    if (price.isNotEmpty && price.isNotEmpty) count = '$price - $priceMax';
    return count;
  }

  phone(String phone, String phone2) {
    if (phone2.isEmpty) {
      return phone;
    } else {
      return '$phone - $phone2';
    }
  }

  Widget textTitle(String text) => Text(text,
      style: Theme.of(context).textTheme.subhead.apply(fontWeightDelta: 700));

  Widget textContent(String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.green[900]));

  Widget textDes(String text) => Text(text,
      style: Theme.of(context)
          .textTheme
          .body1
          .apply(fontFamily: Const.ralewayFont, color: Colors.grey[900]));

  //column1
  Widget profileColumn(BuildContext context, SoccerField field) => Row(
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
                  backgroundImage: field.photoUrl.isEmpty
                      ? AssetImage(Const.icPlaying)
                      : NetworkImage(field.photoUrl),
                ),
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
                  if (field.phone2.isEmpty) {
                    Util.callPhone(field.phone);
                  } else {
                    selectPhone(context, field.phone, field.phone2);
                  }
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
                textTitle(field.name),
                SizedBox(
                  height: Const.size_5,
                ),
                textContent(phone(field.phone, field.phone2)),
                SizedBox(
                  height: Const.size_5,
                ),
                textContent(field.address),
                SizedBox(
                  height: Const.size_10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        textContent(field.amountField.isEmpty
                            ? Const.threeDot
                            : field.amountField),
                        textDes(Const.countField)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        textContent(priceAVG(field.price, field.priceMax)),
                        textDes(Const.priceAVG)
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      );

  //post cards
  Widget postCard(BuildContext context, SoccerField field) => Card(
        margin: const EdgeInsets.only(
            left: Const.size_8, right: Const.size_8, bottom: Const.size_8),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(Const.size_8),
              child: profileColumn(context, field),
            ),
            SizedBox(
              height: Const.size_5,
            ),
          ],
        ),
      );

//allposts dropdown
  Widget bottomBar() => PreferredSize(
      preferredSize: Size(double.infinity, Const.size_50),
      child: Container(
          color: Colors.black,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "All Posts",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )));

  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.green,
        elevation: 2.0,
        title: Text("Feed"),
        forceElevated: true,
        pinned: true,
        floating: true,
        bottom: bottomBar(),
      );

  Widget bodyList(List<SoccerField> fields) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: postCard(context, fields[index]),
            ),
          );
        }, childCount: fields.length),
      );

  Widget _buildListItem(List<SoccerField> fields) => SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: postCard(context, fields[index]),
            ),
          );
        }, childCount: fields.length),
      );

  Widget bodySliverList(List<SoccerField> fields) {
    FieldBloc fieldBloc = FieldBloc(fields);
    return StreamBuilder<List<SoccerField>>(
        stream: fieldBloc.postItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? /*Column(
                  children: <Widget>[*/
              CustomScrollView(
                  slivers: <Widget>[
                    /*Container(
                      width: double.infinity,
                      height: 50.0,
                      child: Text("sâsasa"),
                    ),*/
                    bodyList(snapshot.data),
                  ],
//                    )
//                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream:
              Firestore.instance.collection(Const.fieldsCollection).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green[900])));
//            return bodySliverList(getList(snapshot));
            /*return Column(
              children: <Widget>[
//                Text('Hello'),
                Expanded(
                  child: ListView.builder(
                      itemCount: getList(snapshot).length,
                      itemBuilder: (context, i) {
                        postCard(context, getList(snapshot)[i]);
                      }),
                )
              ],
            );*/
            return SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: bottomBar(),
                  ),
                  Divider(color: Colors.grey, height: 1.0),
                  Expanded(
                    child: Scrollbar(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(top: 8.0),
                            itemCount: getList(snapshot).length,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                  onTap: () => print(i),
                                  child:
                                      postCard(context, getList(snapshot)[i]));

//                  return postCard(context, getList(snapshot)[i]);
                            })),
                  )
                ],
              ),
            );
          }),
    );
  }
}
