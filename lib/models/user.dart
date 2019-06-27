import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userID;
  final String fullName;
  final String email;
  final String phone;
  final String profilePictureURL;

  User({
    this.userID,
    this.fullName,
    this.email,
    this.phone,
    this.profilePictureURL,
  });

  Map<String, Object> toJson() {
    return {
      'userID': userID,
      'firstName': fullName,
      'email': email == null ? '' : email,
      'phone': phone == null ? '' : phone,
      'profilePictureURL': profilePictureURL,
//      'appIdentifier': 'flutter-onboarding'
    };
  }

  factory User.fromJson(Map<String, Object> doc) {
    User user = new User(
      userID: doc['userID'],
      fullName: doc['firstName'],
      email: doc['email'],
      phone: doc['phone'],
      profilePictureURL: doc['profilePictureURL'],
    );
    return user;
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
