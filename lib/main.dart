import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  TextEditingController search = TextEditingController();

  String city = "City";
  String description = "Description";
  String iconSrc = "04d";
  String country = "";
  var temp = 0.0;
  var wind = 0.0;
  var humidity = 0.0;
  var tempMin = 0.0;
  var tempMax = 0.0;
  double seaLevel = 0.0;
  var lon = 0.0;
  var lat = 0.0;

  getWeather() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${search.text}&appid=87edfe8fa9d769d1fdc98d83269a9b9b&units=metric');
    var response = await http.post(url);
    var result = jsonDecode(response.body);

    city = result['name'];
    description = result['weather'][0]['main'];
    country = result['sys']['country'];
    temp = result['main']['temp'];
    wind = result['wind']['speed'];
    humidity = result['main']['humidity'] + 0.0;
    tempMin = result['main']['temp_min'];
    tempMax = result['main']['temp_max'];
    seaLevel = result['main']['sea_level'] + 0.0;
    lon = result['coord']['lon'];
    lat = result['coord']['lat'];
    iconSrc = result['weather'][0]['icon'];

    setState(() {
      city = result['name'];
      description = result['weather'][0]['main'];
      country = result['sys']['country'];
      temp = result['main']['temp'];
      wind = result['wind']['speed'];
      humidity = result['main']['humidity'] + 0.0;
      tempMin = result['main']['temp_min'];
      tempMax = result['main']['temp_max'];
      seaLevel = result['main']['sea_level'] + 0.0;
      lon = result['coord']['lon'];
      lat = result['coord']['lat'];
      iconSrc = result['weather'][0]['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE6E6E6),
          elevation: 10.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "x",
                style: TextStyle(color: Colors.black, fontFamily: 'Comfortaa'),
              ),
              Text(
                "Weather",
                style: TextStyle(color: Colors.cyan, fontFamily: 'Comfortaa'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.cyan,
                    ),
                  ),
                  // borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.only(left: 35, right: 35, top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: search,
                            cursorColor: Colors.black,
                            cursorWidth: 1.0,
                            cursorHeight: 20.0,
                            decoration: InputDecoration(
                              hintText: 'search cities...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.search),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: OutlinedButton(
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                  onPressed: getWeather,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    // color: Color(0xffE6E6E6),
                    borderRadius: BorderRadius.circular(30)),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Image.network(
                                'https://openweathermap.org/img/wn/$iconSrc@2x.png'),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              '$description',
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '$city',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.flag),
                          Padding(
                            child: Text(
                              "Country : $country",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.thermostat),
                          Padding(
                            child: Text(
                              "Temprature : $temp \u00B0c",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.air_rounded),
                          Padding(
                            child: Text(
                              "Wind : $wind km/hr",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.water),
                          Padding(
                            child: Text(
                              "Humidity : $humidity",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.pin_drop),
                          Padding(
                            child: Text(
                              "Latitude : $lat",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.pin_drop),
                          Padding(
                            child: Text(
                              "Longitude : $lon",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.thermostat_sharp),
                          Padding(
                            child: Text(
                              "Temp Min : $tempMin",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.thermostat_sharp),
                          Padding(
                            child: Text(
                              "Temp Max : $tempMax",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Icon(Icons.height),
                          Padding(
                            child: Text(
                              "Sea Level : $seaLevel",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void main() {
  runApp(Weather());
}