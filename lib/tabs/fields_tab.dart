import 'package:bongdaphui/models/soccer_field_model.dart';
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
  List<DropdownMenuItem<String>> list = [];
  String _color = 'red';
  List<String> _colors = <String>['red', 'green', 'blue', 'orange'];

  buildForm() => new FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: Const.size_10, right: Const.size_10),
                labelText: '',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
//            isEmpty: _color == '',
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                value: _color,
                isDense: true,
                onChanged: (String newValue) {
                  setState(() {
                    _color = newValue;
                  });
                },
                items: _colors.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: textTitle(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      );

  Widget dropDow() => SizedBox(
        width: double.infinity,
        height: Const.size_60,
        child: Row(
          children: <Widget>[
            Expanded(
              child: buildForm(),
            ),
            SizedBox(
              width: 0.5,
              height: Const.size_50,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Colors.grey),
              ),
            ),
            Expanded(
              child: buildForm(),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    Util.loadCity();
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
            return SafeArea(
              child: Column(
                children: <Widget>[
                  dropDow(),
                  SizedBox(
                    height: 0.5,
                    width: double.infinity,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  ),
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
                            })),
                  )
                ],
              ),
            );
          }),
    );
  }
}
