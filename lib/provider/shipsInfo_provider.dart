import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_serializable_test/models/ship_info.dart';
import 'package:json_serializable_test/services/services.dart' as services;

class ShipsInfoProvider extends ChangeNotifier {
  List<ShipInfo> _shipsInfo = [];

  List<ShipInfo> get shipsInfo => _shipsInfo;

  addShipInfo(String id, String owner, String shipName) async {
    await services.shipsInfo.doc(id).set({
      'id': id,
      'owner': owner,
      'shipName': shipName,
      'latitude': 0.0,
      'longitude': 0.0
    });

    _shipsInfo.add(ShipInfo(
        id: id,
        owner: owner,
        shipName: shipName,
        latitude: 0.0,
        longitude: 0.0));
    notifyListeners();
  }

  updateShipInfo(String id, double lat, double log) async {
    var index = _shipsInfo.indexWhere((shipInfo) => shipInfo.id == id);

    _shipsInfo.forEach((shipInfo) async {
      if (shipInfo.id == id) {
        //_shipsInfo[index] = Ship

        await services.shipsInfo
            .doc(id)
            .update({'latitude': lat, 'longitude': log});

        _shipsInfo[index] = ShipInfo(
          id: shipInfo.id,
          shipName: shipInfo.shipName,
          latitude: shipInfo.latitude,
          longitude: shipInfo.longitude,
          owner: shipInfo.owner

        );
      }
    });

    notifyListeners();
  }

  fetchShipInfo() async {
    QuerySnapshot querySnapshot = await services.shipsInfo.get();
    List<ShipInfo> shipInfoList = [];
    // querySnapshot.snap.forEach((shipInfo) {
    //   _shipsInfo
    //
    //
    // });
    querySnapshot.docs.forEach((shipInfo) {
      shipInfoList.add(ShipInfo.fromDocument(shipInfo));
    });

    _shipsInfo = shipInfoList;

    notifyListeners();
  }
}
