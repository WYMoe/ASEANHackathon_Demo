


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_serializable_test/models/ais.dart';

class AisProvider extends ChangeNotifier{

  List<AIS> _aisList = [];

  Future<void> getData(BuildContext context) async {

    //PermissionStatus permission = await LocationPermissions().requestPermissions();
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/data.json');
    List<dynamic> decodedData = jsonDecode(data);
    List<AIS> aisList = [];
    decodedData.forEach((ais) {
      ais.forEach((key, value) {
        AIS aisData = AIS.fromJson(value);
        aisList.add(aisData);
      });
    });

    _aisList = aisList;

    notifyListeners();




  }

  List<AIS> get aisList => _aisList;
}