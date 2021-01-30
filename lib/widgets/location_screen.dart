import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:json_serializable_test/models/ship_info.dart';


import 'package:json_serializable_test/provider/user_provider.dart';
import 'package:json_serializable_test/services/services.dart' as services;
import 'package:provider/provider.dart';

import 'package:maps_toolkit/maps_toolkit.dart' as distanceCalculator;

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController _controller;
  final Map<String, Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<ShipInfo> shipInfoList = [];
  CameraPosition initialPos = CameraPosition(target: LatLng(0.0, 0.0), zoom: 17.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  updateMarker(List<ShipInfo> shiplist) {
    setState(() {
      _markers.clear();
      shiplist.forEach((shipInfo) {
        final mk = Marker(
            markerId: MarkerId(shipInfo.id),
            position: LatLng(shipInfo.latitude, shipInfo.longitude));
        _markers[shipInfo.id] = mk;
      });
    });
  }



  @override
  void didChangeDependencies() async {
    //  TODO: implement didChangeDependencies
    updateMarker(shipInfoList);
    super.didChangeDependencies();
  }


  showDistance(double distance,String shipName){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Distance between your ship and ${shipName}'),
            content: Container(
              width: MediaQuery.of(context).size.width *
                  1.2,
              height:
              MediaQuery.of(context).size.height *
                  0.5,
              child: Text("${(distance/1000).toStringAsFixed(2)} kilometers"),
            ),
          );
        });
  }

 @override
  Widget build(BuildContext context) {
    String id = Provider.of<UserProvider>(context, listen: false).user.id;
    return StreamBuilder<QuerySnapshot>(
        stream: services.shipsInfo.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var myLat;
            var myLng;
            snapshot.data.docs.forEach((doc) {
              ShipInfo shipInfo = ShipInfo.fromDocument(doc);
              shipInfoList.add(shipInfo);
              if (shipInfo.id == id) {
                  myLat = shipInfo.latitude;
                  myLng = shipInfo.longitude;
              }
              final mk = Marker(
                  icon: shipInfo.id == id
                      ? BitmapDescriptor.defaultMarkerWithHue(80.0)
                      : null,
                  markerId: MarkerId(shipInfo.id),
                  position: LatLng(shipInfo.latitude, shipInfo.longitude),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      'Ship Name : ${shipInfo.shipName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),),
                                    Divider(),
                                    Text('Owner : ${shipInfo.owner}'),
                                    Text(
                                        'Latitude : ${shipInfo.latitude.toStringAsFixed(4)}'),
                                    Text(
                                        'Longitude : ${shipInfo.longitude.toStringAsFixed(4)}'),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    shipInfo.id == id
                                        ? Container()
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.50,
                                            child: FlatButton(
                                              child: Text(
                                                'Show Distance',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {




                                                  _polylines.clear();
                                                  _polylines.add(Polyline(
                                                      polylineId: PolylineId(
                                                          shipInfo.id),
                                                      points: [
                                                        LatLng(myLat, myLng),
                                                        LatLng(
                                                            shipInfo.latitude,
                                                            shipInfo.longitude)
                                                      ],
                                                    color: Colors.lightGreen,
                                                    patterns: [
                                                      PatternItem.dot,
                                                      PatternItem.gap(25.00)
                                                    ],
                                                    width: 5,
                                                    startCap: Cap.roundCap,
                                                    endCap: Cap.roundCap
                                                  ));

                                                });
                                                var distanceBetweenPoints =
                                                distanceCalculator
                                                    .SphericalUtil
                                                    .computeDistanceBetween(
                                                    distanceCalculator
                                                        .LatLng(
                                                        myLat, myLng),
                                                    distanceCalculator.LatLng(
                                                        shipInfo
                                                            .latitude,
                                                        shipInfo
                                                            .longitude));
                                                print(distanceBetweenPoints);

                                                _scaffoldKey.currentState.hideCurrentSnackBar();
                                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  backgroundColor: Colors.lightGreen,
                                                  duration: Duration(days: 1),

                                                  content: Text("${(distanceBetweenPoints/1000).toStringAsFixed(2)} kilometers",
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),),
                                                  action: SnackBarAction(
                                                      label: 'HIDE',
                                                      onPressed: () {
                                                        setState(() {
                                                          _polylines.clear();
                                                        });
                                                      }),
                                                  elevation: 2.0,
                                                ));
                                              },
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Colors.lightGreen,
                                            ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  });
              _markers[shipInfo.id] = mk;
            });

            return Scaffold(
              key:_scaffoldKey,
              body: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) async {
                      _controller = controller;
                      snapshot.data.docs.forEach((doc) {
                        if (doc.id == id) {
                          ShipInfo shipInfo = ShipInfo.fromDocument(doc);
                          _controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  zoom: 17.0,
                                  target: LatLng(
                                    shipInfo.latitude,
                                    shipInfo.longitude,
                                  ))));
                        }
                      });
                    },
                    initialCameraPosition: initialPos,
                    mapType: MapType.hybrid,
                    markers: _markers.values.toSet(),
                    polylines: _polylines,
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                  ),
                  Positioned(
                    right: 30,
                    bottom: 80,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          heroTag: 'btn1',
                          backgroundColor: Colors.lightGreen,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Location of all ships'),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          1.2,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder: (context, index) {
                                          // snapshot.data.docs.forEach((doc) {
                                          //
                                          //
                                          //   ShipLIstTile listTile = ShipLIstTile(shipInfo: shipInfo, controller: _controller);
                                          //
                                          // });
                                          ShipInfo shipInfo =
                                              ShipInfo.fromDocument(
                                                  snapshot.data.docs[index]);
                                          return ShipLIstTile(
                                              shipInfo: shipInfo,
                                              controller: _controller);
                                        },
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FloatingActionButton(
                          child: Icon(
                            Icons.my_location,
                            color: Colors.white,
                          ),
                          heroTag: 'btn2',
                          backgroundColor: Colors.lightGreen,
                          onPressed: () {
                            snapshot.data.docs.forEach((shipInfo) {
                              if (shipInfo.id == id) {
                                _controller.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            zoom: 17.0,
                                            target: LatLng(
                                            ShipInfo.fromDocument(shipInfo).latitude,
                                              ShipInfo.fromDocument(shipInfo).longitude,
                                            ))));
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        });
  }
}

class ShipLIstTile extends StatelessWidget {
  const ShipLIstTile({
    Key key,
    @required this.shipInfo,
    @required GoogleMapController controller,
  })  : _controller = controller,
        super(key: key);

  final ShipInfo shipInfo;
  final GoogleMapController _controller;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Ship Name : " + shipInfo.shipName),
      leading: CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          ('Ship').toString(),
          style: TextStyle(color: Colors.white),
        ),

      ),
      subtitle: Text(
        "Owner : " + shipInfo.owner,
      ),
      onTap: () {
        Navigator.pop(context);
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: 17.0,
            target: LatLng(
              shipInfo.latitude,
              shipInfo.longitude,
            ))));
      },
    );
  }
}
