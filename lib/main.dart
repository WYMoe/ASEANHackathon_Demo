import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:json_serializable_test/home.dart';

import 'package:json_serializable_test/provider/ais_provider.dart';
import 'package:json_serializable_test/provider/shipsInfo_provider.dart';
import 'package:json_serializable_test/provider/user_provider.dart';
import 'package:json_serializable_test/screens/weather_screen.dart';
import 'file:///D:/IntelliJ%20Flutter%20Apps/studies/json_serializable_test/lib/test/user_provider_test.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';
import 'screens/add_ship_info.dart';
import 'services/services.dart' as services;
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AisProvider()),
        ChangeNotifierProvider.value(value: ShipsInfoProvider()),
        ChangeNotifierProvider.value(value: UserProvider())
      ],
      child: MaterialApp(
        title: 'Hackathon Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          accentColor: Colors.white,
          fontFamily: 'BalooTamma2-Regular',
          visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(
                iconTheme: IconThemeData(
                    color: Colors.white
                )
            )
        ),
        home: InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isLoading = false;
  bool isAccAlreadyExisted = false;
  // bool isDone = false;
  // User u ;
  // GoogleSignInAccount gAcc ;

  createUser() async {
    // final GoogleSignInAccount googleAccount = services.googleSignIn.currentUser;
    // DocumentSnapshot doc = await services.users.doc(googleAccount.id).get();
    // if(!doc.exists){
    //   await services.users.doc(googleAccount.id).set({
    //     "id": googleAccount.id,
    //     "photoUrl": googleAccount.photoUrl,
    //     "email": googleAccount.email,
    //     "displayName": googleAccount.displayName,
    //   });
    //   u =  User(
    //     id: googleAccount.id,
    //     photoUrl: googleAccount.photoUrl,
    //     email: googleAccount.email,
    //     displayName: googleAccount.displayName
    //   );
    // }else{
    //   print('acc already exist');
    //   u = User.fromDocument(doc);
    //   print(u.displayName);
    // }
    setState(() {
      isLoading = true;
    });
    final GoogleSignInAccount googleAccount = services.googleSignIn.currentUser;
    DocumentSnapshot doc = await services.users.doc(googleAccount.id).get();

    if (!doc.exists) {
      await Provider.of<UserProvider>(context, listen: false)
          .addUser(googleAccount);
    } else {
      print('acc already exist');
      setState(() {
        isAccAlreadyExisted = true;
      });
    }
    await Provider.of<UserProvider>(context, listen: false)
        .fetchUser(googleAccount.id);
    setState(() {
      isLoading = false;
    });
  }

  handleSignIn(GoogleSignInAccount account) async {
    if (account != null) {
      createUser();
    } else {
      print('acc null');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
  services.googleSignIn.signOut();


    services.googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    if (user != null) {
      //print(user.email.toString());
      return isAccAlreadyExisted ? Home() : AddShipInfo();
    }

    return isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreen,
              ),
            ),
            color: Colors.white,
          )
        : SignInScreen();
  }
}
