import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_serializable_test/models/user.dart';
import 'package:json_serializable_test/services/services.dart' as services;

class UserProvider extends ChangeNotifier {
  //User _user ;
  User _user;
User get user => _user;

  addUser(GoogleSignInAccount googleAccount) async {
    await services.users.doc(googleAccount.id).set({
      "id": googleAccount.id,
      "photoUrl": googleAccount.photoUrl,
      "email": googleAccount.email,
      "displayName": googleAccount.displayName,
    });
    _user=User(
        photoUrl: googleAccount.photoUrl,
        displayName: googleAccount.displayName,
        id: googleAccount.id,
        email: googleAccount.email);

    notifyListeners();
  }

  fetchUser(String id) async {
    DocumentSnapshot doc = await services.users.doc(id).get();
    _user = User.fromDocument(doc);

    notifyListeners();
  }


}
