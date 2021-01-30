
import 'package:flutter/material.dart';
import 'package:json_serializable_test/home.dart';
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
  String _owner;
  String _shipName;

  @override
  void initState() {
    // TODO: implement initState
    _owerFocus = FocusNode();
    _shipNameFocus = FocusNode();


    super.initState();
  }




  void _saveForm(String id) async {
    _formKey.currentState.save();
    await Provider.of<ShipsInfoProvider>(context,listen: false).addShipInfo(id, _owner, _shipName);



  }

  @override
  Widget build(BuildContext context) {
    User u =  Provider.of<UserProvider>(context,listen: false).user;
  //print(u.email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Ship Info',
        style: TextStyle(
          color: Colors.white
        ),),
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

                  TextFormField(
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
                    focusNode: _shipNameFocus,
                    onSaved: (shipName) {
                      _shipName = shipName;
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (ctx){
                        return Home();
                      }));
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                      width: MediaQuery.of(context).size.width*0.50,
                      child: FlatButton( child: Text('Save',
                      style: TextStyle(
                        color: Colors.white
                      ),),
                      onPressed: () {
                        _saveForm(u.id);
                      },),
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
