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

class MyVessel extends StatefulWidget {
  MyVessel({this.id});
  final String id;
  @override
  _MyVesselState createState() => _MyVesselState();
}

class _MyVesselState extends State<MyVessel> {
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




  void _saveForm(String id) async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      await services.shipsInfo.doc(id).update({
        'owner': _owner,
        'shipName': _shipName,
        'registration': _regNo,
        'year_built': _yearBuilt,
        'company_name': _companyName,
        'address': _address,
        'contact': _contactNumber,
        'type': _type
      });
    }

  }
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



  @override
  Widget build(BuildContext context) {

    print(this.widget.id);

    return StreamBuilder<QuerySnapshot>(
      stream:  FirebaseFirestore.instance.collection('shipsInfo').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          ShipInfo s ;
          snapshot.data.docs.forEach((snapshot) {
            if(snapshot.id==this.widget.id){
               s = ShipInfo.fromDocument(snapshot);
            }
          });



          return Scaffold(
            appBar: AppBar(
              title: Text(
                'My Vessel',
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
                        TextFormField(initialValue:s.owner,
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
                          initialValue: s.shipName,
                          focusNode: _shipNameFocus, onFieldSubmitted: (_) {
                          _regFocus.requestFocus();
                        },
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
                          initialValue: s.regNum,
                          focusNode: _regFocus,
                          onFieldSubmitted: (_) {
                            _yearBuiltFocus.requestFocus();
                          },
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
                          initialValue: s.yearBuilt.toString(),
                          focusNode: _yearBuiltFocus,
                            onFieldSubmitted: (_) {
                              _companyNameFocus.requestFocus();
                            },
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
                          initialValue: s.companyName.toString(),
                          focusNode: _companyNameFocus,
                            onFieldSubmitted: (_) {
                              _addressFocus.requestFocus();
                            },
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
                          initialValue:s.address,
                          focusNode: _addressFocus,
                            onFieldSubmitted: (_) {
                              _contactFocus.requestFocus();
                            },
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
                          initialValue: s.contact.toString(),
                          focusNode: _contactFocus,
                            onFieldSubmitted: (_) {
                              _typeFocus.requestFocus();
                            },
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

                          initialValue: s.type,
                          focusNode: _typeFocus,

                          onSaved: (type) {
                            _type = type;
                          },
                          validator: (a){
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
                                _saveForm(this.widget.id);
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




        return Container();
      }
    );
  }
}
