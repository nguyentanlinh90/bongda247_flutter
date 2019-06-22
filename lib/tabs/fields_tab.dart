import 'package:bongdaphui/logic/bloc/field_bloc.dart';
import 'package:bongdaphui/models/soccer_field.dart';
import 'package:bongdaphui/utils/const.dart';
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
  //column1
  Widget profileColumn(BuildContext context, SoccerField field) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.green[900],
            backgroundImage: field.photoUrl.isEmpty
                ? AssetImage(Const.icPlaying)
                : NetworkImage(field.photoUrl),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  field.name,
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .apply(fontWeightDelta: 700),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  field.phone,
                  style: Theme.of(context).textTheme.caption.apply(
                      fontFamily: Const.ralewayFont, color: Colors.green[900]),
                )
              ],
            ),
          ))
        ],
      );

  //post cards
  Widget postCard(BuildContext context, SoccerField field) => Card(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: profileColumn(context, field),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                field.address,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: Const.ralewayFont),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      );

//allposts dropdown
  Widget bottomBar() => PreferredSize(
      preferredSize: Size(double.infinity, 50.0),
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
