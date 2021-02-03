import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_serializable_test/home.dart';
import 'package:json_serializable_test/main.dart';
import 'package:json_serializable_test/models/user.dart';
import 'package:json_serializable_test/provider/user_provider.dart';
import 'package:json_serializable_test/screens/add_ship_info.dart';
import 'package:json_serializable_test/screens/my_vessel.dart';
import 'package:json_serializable_test/screens/sign_in_screen.dart';
import 'package:json_serializable_test/screens/weather_screen.dart';
import 'package:json_serializable_test/services/services.dart' as services;
import 'package:provider/provider.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerHeader(

              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Expanded(
                    child: Center(
                      child:CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.lightGreen,
                      ) ,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      '${user.displayName}',
                      style: TextStyle(fontSize: 18.0, color: Colors.lightGreen),
                    ),
                  ),
                ],
              )),
          GestureDetector(
            onTap: () {


              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Home();
                  }
              ));

            },
            child: ListTile(
              leading: Icon(
                Icons.map_outlined,
                color: Colors.lightGreen,
              ),
              title: Text('Vessels Data'),
            ),
          ),
          GestureDetector(
            onTap: () {

              Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return WeatherScreen();
                }
              ));
            },
            child: ListTile(
              leading: Icon(Icons.wb_cloudy, color: Colors.lightGreen),
              title: Text('Weather'),

            ),
          ), GestureDetector(
            child: ListTile(
              leading: Icon(Icons.panorama_horizontal_select, color: Colors.lightGreen),
              title: Text('My Vessel'),
            ),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return MyVessel(id: user.id,);
                  }
              ));
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.person, color: Colors.lightGreen),
              title: Text('About Us'),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Icon(Icons.support_agent, color: Colors.lightGreen),
              title: Text('Contact'),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 30.0,
          )
        ],
      ),
    );
  }
}
