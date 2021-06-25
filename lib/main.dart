import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xWeather',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
      ),
      home: MyHomePage(title: 'xWeather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController search = TextEditingController();

  String city = "City";
  String description = "Description";
  String iconSrc = "04n";
  var temp = 0.0;
  var wind = 0.0;

  getWeather() async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${search.text}&appid=87edfe8fa9d769d1fdc98d83269a9b9b&units=metric');
    var response = await http.post(url);
    var result = jsonDecode(response.body);

    city = result['name'];
    description = result['weather'][0]['main'];
    temp = result['main']['temp'];
    wind = result['wind']['speed'];
    iconSrc = result['weather'][0]['icon'];

    setState(() {
      // print("state change");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 20,
        title: Center(
          child: Text(
            'xWeather',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
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
              margin: EdgeInsets.only(left: 35, right: 35, top: 40),
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
                child: Text("Search"),
                onPressed: getWeather,
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                  color: Colors.cyan,
                )),
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
                            style: TextStyle(fontSize: 36),
                          ),
                        ),
                        Container(
                          child: Text(
                            '$city',
                            style: TextStyle(fontSize: 12),
                          ),
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
                          child: Text("Temprature : $temp \u00B0c"),
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
                          child: Text("Wind : $wind km/hr"),
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
    );
  }
}
