import 'package:WeatherApp/second.dart';
import 'package:flutter/material.dart';
import "second.dart";
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class first extends StatefulWidget {
  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  var _currentAddress;
  String lat;
  String long;
  var city = new TextEditingController();
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var cityname;
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      setState(() {
        //_currentPosition = position;
        lat = position.latitude.toString();
        long = position.longitude.toString();
      });
      //PLEASE USE WEATHER API FROM https://openweathermap.org/api
      http.Response response = await http.get(
          "http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&units=metric&appid=da00d3b1397279590c1830927fad1de4");
      var results = jsonDecode(response.body);

      setState(() {
        this.temp = results['main']['temp'];
        this.description = results['weather'][0]['description'];
        this.currently = results['weather'][0]['main'];
        this.humidity = results['main']['humidity'];
        this.windspeed = results['wind']['speed'];
        this.cityname = results['name'];
      });
      print(lat);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // set it to fals
        appBar: AppBar(
        title: Text("171011400503 - Mega Christina"),
        ),
      body: Container(

        width: double.infinity,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Column(children: <Widget>[
              Container(
                  width: double.infinity,
                  height: 200,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/img1.gif'),
                      fit: BoxFit.cover,
                    ),
                  )
                //
              ),
            ]),
            Container(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text("Weather App",
                        style: TextStyle(
                            fontFamily: 'JosefinSans',
                            fontSize: 50,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: TextField(
                              controller: city,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                hintText: 'Enter City',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search, color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => second(
                                            text: city.text,
                                          ),
                                        ));
                                    print(city.text);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
                    SizedBox(height: 40),
                    Container(
                      height: 200,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      //color: Colors.black,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                        color: Color(0xff9FA8DA),
                        boxShadow: [
                          //background color of box
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0, // soften the shadow
                            spreadRadius: -10.0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              0.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              cityname != null
                                  ? cityname.toString() + "\u00b0"
                                  : "Loading",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 3,
                                  fontFamily: 'JosefinSans'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(children: <Widget>[
                                    Icon(Icons.thermostat_rounded),
                                    Text(
                                      temp != null
                                          ? temp.toString() + "\u00b0"
                                          : "Loading",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.0,
                                        //fontWeight: FontWeight.w700,
                                        fontFamily: 'JosefinSans',
                                        letterSpacing: 3,
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Row(children: <Widget>[
                                    Icon(Icons.cloud_circle_sharp),
                                    Text(
                                      currently != null
                                          ? currently.toString() + "\u00b0"
                                          : "Loading",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.0,
                                          //fontWeight: FontWeight.w700,
                                          fontFamily: 'JosefinSans'),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
