import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_serializable_test/home.dart';
import 'package:json_serializable_test/models/ship_info.dart';
import 'package:json_serializable_test/models/user.dart';
import 'package:json_serializable_test/provider/shipsInfo_provider.dart';
import 'package:json_serializable_test/provider/user_provider.dart';
import 'file:///D:/IntelliJ%20Flutter%20Apps/studies/json_serializable_test/lib/test/user_provider_test.dart';
import 'package:json_serializable_test/services/services.dart' as services;
import 'package:provider/provider.dart';

class AddShipInfo extends StatefulWidget {

  @override
  _AddShipInfoState createState() => _AddShipInfoState();
}

class _AddShipInfoState extends State<AddShipInfo> {
  final _formKey = GlobalKey<FormState>();
  bool _isInit = true;

  FocusNode _owerFocus;
  FocusNode _shipNameFocus;
  FocusNode _regFocus;
  FocusNode _yearBuiltFocus;
  FocusNode _companyNameFocus;
  FocusNode _addressFocus;
  FocusNode _contactFocus;
  FocusNode _typeFocus;
  String _owner;
  String _shipName;
  String _regNo;
  int _yearBuilt;
  String _companyName;
  String _address;
  int _contactNumber;
  bool _isAISFitted;
  String _type;

  var _inItValues = {
    'id': '',
    'owner': '',
    'shipName': '',
    'registration': '',
    'year_built': '',
    'company_name': '',
    'address': '',
    'contact': '',
    'type': ''
  };
  @override
  void initState() {
    // TODO: implement initState
    _owerFocus = FocusNode();
    _shipNameFocus = FocusNode();
    _regFocus = FocusNode();
    _yearBuiltFocus = FocusNode();
    _companyNameFocus = FocusNode();
    _addressFocus = FocusNode();
    _contactFocus = FocusNode();
    _typeFocus = FocusNode();
    super.initState();
  }

  void _saveForm(String id) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      await Provider.of<ShipsInfoProvider>(context, listen: false).addShipInfo(
          id,
          _owner,
          _shipName,
          _regNo,
          _yearBuilt,
          _companyName,
          _address,
          _contactNumber,
          _type);
    }
  }



  @override
  Widget build(BuildContext context) {
    User u = Provider.of<UserProvider>(context, listen: false).user;
    //print(u.email);
    print(_inItValues);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Ship Info',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(initialValue: _inItValues['owner'],
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _owerFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Owner Name',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),

                    focusNode: _owerFocus,
                    onFieldSubmitted: (_) {
                      _shipNameFocus.requestFocus();
                    },
                    onSaved: (owner) {
                      _owner = owner;
                    },validator: (a){
                      if(a.isEmpty){
                        return 'Please enter a description.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _shipNameFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Ship Name',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['shipName'],
                    focusNode: _shipNameFocus,
                    onSaved: (shipName) {
                      _shipName = shipName;
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _regFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Registration Number',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['registration'],
                    focusNode: _regFocus,
                    onSaved: (regNum) {
                      _regNo = regNum;
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _yearBuiltFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Year Built',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['year_built'],
                    focusNode: _yearBuiltFocus,
                    onSaved: (year) {
                      _yearBuilt = int.parse(year);
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _companyNameFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Company Name',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['company_name'],
                    focusNode: _companyNameFocus,
                    onSaved: (company) {
                      _companyName = company;
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _addressFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Flag',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['address'],
                    focusNode: _addressFocus,
                    onSaved: (address) {
                      _address = address;
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _contactFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Contact Number',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    initialValue: _inItValues['contact'],
                    focusNode: _contactFocus,
                    onSaved: (c) {
                      _contactNumber = int.parse(c);
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      labelStyle: TextStyle(
                          color: _typeFocus.hasFocus
                              ? Colors.blueGrey
                              : Colors.blueGrey),
                      labelText: 'Type',
                      fillColor: Colors.blueGrey[30],
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey)),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    focusNode: _typeFocus,
                    onSaved: (type) {
                      _type = type;
                    },validator: (a){
                    if(a.isEmpty){
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: FlatButton(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          _saveForm(u.id);
                          //  Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                            return Home();
                          }));
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.lightGreen,
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
