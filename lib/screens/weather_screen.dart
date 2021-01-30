import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:json_serializable_test/services/my_location.dart';
import 'package:json_serializable_test/widgets/app_drawer.dart';
import 'package:json_serializable_test/services/services.dart' as services;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var temp;
  var description;
  var pressure;
  var humidity;

  double windSpeed;
  var tempMin;
  var tempMax;
  var iconUrl;
  var sunRises;
  var sunSets;
  Icon icon;

  Future getWeather() async {
    MyLocation location = MyLocation();
    await location.getLocation();
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=758171ee0bb02d0190e7e4304d2d708b&units=metric");
    var results = jsonDecode(response.body);

    setState(() {
      this.description = results['weather'][0]['description'];
      this.temp = results['main']['temp'];
      this.pressure = results['main']['pressure'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
      this.tempMax = results['main']['temp_max'];
      this.tempMin = results['main']['temp_min'];
      this.sunRises = DateTime.fromMillisecondsSinceEpoch(
          results['sys']['sunrise'] * 1000,
          isUtc: false);
      this.sunSets = DateTime.fromMillisecondsSinceEpoch(
          results['sys']['sunset'] * 1000,
          isUtc: false);

      this.iconUrl =
          'http://openweathermap.org/img/w/${results["weather"][0]["icon"]}.png';

      if ((results['weather'][0]['id']) >= 200 &&
          (results['weather'][0]['id']) < 300) {
        this.icon = Icon(
          WeatherIcons.wiThunderstorm,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) >= 300 &&
          (results['weather'][0]['id']) < 500) {
        this.icon = Icon(
          WeatherIcons.wiRaindrop,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) >= 500 &&
          (results['weather'][0]['id']) < 600) {
        this.icon = Icon(
          WeatherIcons.wiRaindrops,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) >= 600 &&
          (results['weather'][0]['id']) < 700) {
        this.icon = Icon(
          WeatherIcons.wiSnow,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) >= 700 &&
          (results['weather'][0]['id']) < 800) {
        this.icon = Icon(
          WeatherIcons.wiFog,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) == 800) {
        this.icon = Icon(
          WeatherIcons.wiDaySunny,
          size: 50,
          color: Colors.lightGreen,
        );
      } else if ((results['weather'][0]['id']) >= 800) {
        this.icon = Icon(
          WeatherIcons.wiCloud,
          size: 50,
          color: Colors.lightGreen,
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'Current Weather',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(DateFormat.yMMMd().format(new DateTime.now()),
                  style: TextStyle(fontSize: 30)),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.lightGreen,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(
                      description != null ? description.toString() : '',
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text(
                      temp != null ? '${temp.toString()}°C' : '',
                      style: TextStyle(fontSize: 30),
                    ),
                    // trailing: iconUrl!=null?Image(
                    //   width: MediaQuery.of(context).size.width*0.3,
                    //   height: MediaQuery.of(context).size.height*0.08,
                    //   image: NetworkImage(
                    //     iconUrl
                    //   ),
                    //   fit: BoxFit.cover,
                    // ):Text(''),
                    trailing: icon,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Wind Speed',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        windSpeed != null
                            ? '${(windSpeed * 2.23694).toStringAsFixed(2)} mph'
                            : '',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Humidity',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        humidity != null ? '$humidity %' : '',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pressure',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        pressure != null ? '$pressure hPa' : ' ',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
              Divider(
                height: 10.0,
                color: Colors.lightGreen,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Details', style: TextStyle(fontSize: 15)),
                  ListTile(
                    title: Text(
                      'Max Temp',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      tempMax != null ? '$tempMax°C' : '',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Min Temp',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      tempMin != null ? '$tempMin°C' : '',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sun Rises',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      sunRises != null ? DateFormat.jm().format(sunRises) : '',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sun Sets',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      sunSets != null ? DateFormat.jm().format(sunSets) : '',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
