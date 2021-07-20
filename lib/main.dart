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
  String iconSrc = "11d";
  String country = "";
  var temp = 0.0;
  var wind = 0.0;
  var humidity = 0.0;
  var tempMin = 0.0;
  var tempMax = 0.0;
  var seaLevel = 0.0;
  var lon = 0.0;
  var lat = 0.0;
  Widget icon = Image(image: AssetImage('icon/11d.png'));

  getWeather() async {
    if (search.text == "") {
      setState(() {
        search.clear();
        description = 'Error';
        city = 'City Not Found. Please Try Again!';
        country = "N/A";
        temp = 0.0;
        wind = 0.0;
        humidity = 0.0;
        tempMin = 0.0;
        tempMax = 0.0;
        seaLevel = 0.0;
        lon = 0.0;
        lat = 0.0;
        icon = Container(
          width: 90,
          height: 90,
          child: Image(
            image: AssetImage('icon/x.png'),
          ),
        );
      });
    } else {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${search.text}&appid=87edfe8fa9d769d1fdc98d83269a9b9b&units=metric');
      var response = await http.post(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        setState(() {
          search.clear();
          city = result['name'];
          description = result['weather'][0]['main'];
          country = result['sys']['country'];
          temp = result['main']['temp'];
          wind = result['wind']['speed'] + 0.0;
          humidity = result['main']['humidity'] + 0.0;
          tempMin = result['main']['temp_min'];
          tempMax = result['main']['temp_max'];
          // seaLevel = result['main']['sea_level'];
          if (result['main']['sea_level'] != null) {
            seaLevel = result['main']['sea_level'] + 0.0;
          } else {
            seaLevel = 0.0;
          }
          lon = result['coord']['lon'];
          lat = result['coord']['lat'];
          iconSrc = result['weather'][0]['icon'];
          icon = Image.network(
              'https://openweathermap.org/img/wn/$iconSrc@2x.png');
        });
      } else {
        setState(() {
          search.clear();
          description = 'Error';
          city = 'City Not Found. Please Try Again!';
          country = "N/A";
          temp = 0.0;
          wind = 0.0;
          humidity = 0.0;
          tempMin = 0.0;
          tempMax = 0.0;
          seaLevel = 0.0;
          lon = 0.0;
          lat = 0.0;
          icon = Container(
            width: 90,
            height: 90,
            child: Image(
              image: AssetImage('icon/x.png'),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.cyan,
        primarySwatch: Colors.cyan,
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
              OutlinedButton(
                onPressed: getWeather,
                child: Text('Search'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.cyan,
                  textStyle: TextStyle(
                    color: Colors.cyan,
                  ),
                  side: BorderSide(
                    color: Colors.cyan,
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
                            // child: Image.network(
                            //   'https://openweathermap.org/img/wn/$iconSrc@2x.png',
                            // ),
                            // child: Image(image: AssetImage('icon/11d.png'),),
                            child: icon,
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
