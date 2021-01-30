import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final googleSignIn = GoogleSignIn();
final users = FirebaseFirestore.instance.collection('users');

final shipsInfo = FirebaseFirestore.instance.collection('shipsInfo');
final weatherAPIKEY = '758171ee0bb02d0190e7e4304d2d708b';