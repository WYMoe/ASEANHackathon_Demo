import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:json_serializable_test/models/ais.dart';
import 'package:json_serializable_test/models/ship_info.dart';
import 'package:json_serializable_test/provider/ais_provider.dart';
import 'package:json_serializable_test/provider/shipsInfo_provider.dart';
import 'package:json_serializable_test/provider/user_provider.dart';

import 'package:provider/provider.dart';

class AisScreen extends StatefulWidget {
  @override
  _AisScreenState createState() => _AisScreenState();
}

class _AisScreenState extends State<AisScreen> {
  LatLng _center= LatLng(46.1455, -1.16630);
  final Map<String, Marker> _markers = {};
  GoogleMapController _controller;



  StreamSubscription _locationSubscription;
  Geolocator _locationTracker = Geolocator();


  // Future<Uint8List> getMarker()async{
  //   ByteData byteData = await DefaultAssetBundle.of(context).load('assets/images/dot.png');
  //   return byteData.buffer.asUint8List();
  //
  // }

  // void locatePosition()async{
  //
  //
  //
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  //
  //   setState(() {
  //     _center = LatLng( position.latitude,position.longitude);
  //   });
  //   if(_locationSubscription!=null){
  //     _locationSubscription.cancel();
  //   }
  //
  //   String id =  Provider.of<UserProvider>(context,listen: false).user.id;
  //
  //
  //
  //   _locationSubscription = Geolocator.getPositionStream(
  //   desiredAccuracy: LocationAccuracy.high,
  //   distanceFilter: 1).listen((Position position) async{
  //
  //     await Provider.of<ShipsInfoProvider>(context,listen: false).updateShipInfo(id,position.latitude,position.longitude);
  //     print(position.longitude);
  //   });
  //
  //
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // locatePosition();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    List<AIS> aisDataList =
        Provider.of<AisProvider>(context, listen: false).aisList;
    setState(() {
      _markers.clear();
      aisDataList.forEach((aisData) async {
        final marker = Marker(
            //  icon: BitmapDescriptor.fromBytes(await getMarker() ),
            markerId: MarkerId(aisData.NAME),
            position: LatLng(aisData.LATITUDE, aisData.LONGITUDE),

            // infoWindow: InfoWindow(
            //     title:'Ship Name : ${aisData.NAME}',
            //     snippet: 'Destination : ${aisData.DESTINATION}  Latitude:${aisData.LATITUDE} \n Longitude:${aisData.LONGITUDE}'
            // )
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text('Ship Name : ${aisData.NAME}',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                              ),),
                              Divider(),
                              Text('Latitude : ${aisData.LATITUDE}'),
                              Text('Longitude : ${aisData.LONGITUDE}'),
                              Text('Speed : ${aisData.SPEED}'),
                              Text('Destination : ${aisData.DESTINATION}'),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            });
        _markers[aisData.NAME] = marker;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future:
            Provider.of<AisProvider>(context, listen: false).getData(context),
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _center, zoom: 17.0),
              mapType: MapType.hybrid,
              markers: _markers.values.toSet(),


            ),
          );
        });
  }
}
