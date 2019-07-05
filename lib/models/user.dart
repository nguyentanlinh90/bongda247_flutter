import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userID;
  final String fullName;
  final String email;
  final String phone;
  final String profilePictureURL;
  final List<dynamic> clubs;


  UserModel({
    this.userID,
    this.fullName,
    this.email,
    this.phone,
    this.profilePictureURL,
    this.clubs,
  });

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'fullName': fullName,
      'email': email == null ? '' : email,
      'phone': phone == null ? '' : phone,
      'profilePictureURL': profilePictureURL,
      'profilePictureURL': clubs,
//      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory UserModel.fromJson(Map<String, Object> doc) {
    UserModel user = new UserModel(
      userID: doc['userID'],
      fullName: doc['fullName'],
      email: doc['email'],
      phone: doc['phone'],
      profilePictureURL: doc['profilePictureURL'],
      clubs: doc['clubs'],
    );
    return user;
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel.fromJson(doc.data);
  }
}
