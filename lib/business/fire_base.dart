import 'package:bongdaphui/models/match_model.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:bongdaphui/listener/insert_listener.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBase {

  /*static Future<FirebaseUser> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }*/
  static Stream<User> getUser(String userID) {
    return Firestore.instance
        .collection("${Const.usersCollection}")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return User.fromDocument(doc);
      }).first;
    });
  }
  static Future<void> addMatch(MatchModel model) async {
    Firestore.instance
        .document('${Const.matchCollection}/${model.id}')
        .setData(model.toJson());
  }



}
