import 'dart:async';

import 'package:flutter/material.dart';
import 'package:json_serializable_test/models/ship_info.dart';
import 'package:json_serializable_test/provider/shipsInfo_provider.dart';
import 'package:json_serializable_test/provider/user_provider.dart';
import 'package:json_serializable_test/services/my_location.dart';
import 'package:json_serializable_test/widgets/ais_screen.dart';
import 'package:json_serializable_test/widgets/location_screen.dart';
import 'package:provider/provider.dart';
import 'widgets/app_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_serializable_test/services/services.dart' as services;
import 'package:maps_toolkit/maps_toolkit.dart' as distanceCalculator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription _locationSubscription;


  void locatePosition() async {
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.best);

    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }

    String id = Provider.of<UserProvider>(context, listen: false).user.id;

    _locationSubscription = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high, distanceFilter: 20)
        .listen((Position position) async {
      await Provider.of<ShipsInfoProvider>(context, listen: false)
          .updateShipInfo(id, position.latitude, position.longitude);
      //print(position.longitude);
    });
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var initializationSettingsAndroid =
    // new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = new IOSInitializationSettings();
    // var initializationSettings = new InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);
  }
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Alert',
      'A ship is near you',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }


  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
  await Provider.of<ShipsInfoProvider>(context, listen: false).fetchShipInfo();
     locatePosition();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text(
              'Hackathon Demo',
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                    child: Text(
                  'AIS Based Data',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )),
                Tab(
                    child: Text(
                  'Location Based Data',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )),
              ],
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: services.shipsInfo.snapshots(),
            builder: (context, snapshot) {

              if(!snapshot.hasData){
                return Container();
              }

              //
              // snapshot.data.docs.forEach((ds) async{
              //   ShipInfo shipInfo = ShipInfo.fromDocument(ds);
              //
              //   MyLocation location = MyLocation();
              //   await location.getLocation();
              //   var distanceBetweenPoints =
              //   distanceCalculator
              //       .SphericalUtil
              //       .computeDistanceBetween(
              //       distanceCalculator
              //           .LatLng(
              //           location.latitude, location.longitude),
              //       distanceCalculator.LatLng(
              //          16.2484533,
              //           96.1862217));
              //
              //   if(distanceBetweenPoints<1000){
              //         _showNotificationWithDefaultSound();
              //   }
              //
              // });

              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [AisScreen(), LocationScreen()],
              );
            }
          ),
        ));
  }
}
