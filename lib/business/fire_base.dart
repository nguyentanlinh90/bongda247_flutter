import 'package:bongdaphui/models/club.dart';
import 'package:bongdaphui/models/match.dart';
import 'package:bongdaphui/models/user.dart';
import 'package:bongdaphui/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBase {
  /*static Future<FirebaseUser> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }*/
  static Stream<UserModel> getUser(String userID) {
    return Firestore.instance
        .collection("${Const.usersCollection}")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((doc) {
        return UserModel.fromDocument(doc);
      }).first;
    });
  }

  static Future<void> addMatch(MatchModel model) async {
    Firestore.instance
        .document('${Const.matchCollection}/${model.id}')
        .setData(model.toJson());
  }

  static Future<void> addClub(ClubModel model) async {
    Firestore.instance
        .document('${Const.clubCollection}/${model.id}')
        .setData(model.toJson());
  }
}
