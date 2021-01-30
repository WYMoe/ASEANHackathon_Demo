import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:json_serializable_test/models/user.dart';
import 'package:json_serializable_test/services/services.dart' as services;

class UserProviderTest extends ChangeNotifier {
  //User _user ;
  List<User> _user;
  List<User> get user => _user;

  addUser(GoogleSignInAccount googleAccount) async {
    await services.users.doc(googleAccount.id).set({
      "id": googleAccount.id,
      "photoUrl": googleAccount.photoUrl,
      "email": googleAccount.email,
      "displayName": googleAccount.displayName,
    });
    _user.add(User(
        photoUrl: googleAccount.photoUrl,
        displayName: googleAccount.displayName,
        id: googleAccount.id,
        email: googleAccount.email));

    notifyListeners();
  }

  fetchUser() async {
    QuerySnapshot users = await services.users.get();
    List<User> userList = [];
    users.docs.forEach((user) {
      userList.add(User.fromDocument(user));
    });
    _user = userList;

    notifyListeners();
  }

  User getUserById(String id){
    return _user.firstWhere((user) => id==user.id);
  }
}
