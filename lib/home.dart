import 'dart:async';

import 'package:flutter/material.dart';
import 'package:json_serializable_test/provider/shipsInfo_provider.dart';
import 'package:json_serializable_test/provider/user_provider.dart';
import 'package:json_serializable_test/widgets/ais_screen.dart';
import 'package:json_serializable_test/widgets/location_screen.dart';
import 'package:provider/provider.dart';
import 'widgets/app_drawer.dart';
import 'package:geolocator/geolocator.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [AisScreen(), LocationScreen()],
          ),
        ));
  }
}
