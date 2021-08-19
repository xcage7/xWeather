import 'package:flutter/material.dart';
import 'package:xweather/files/search.dart';

void main() {
  runApp(Weather());
}

class Weather extends StatefulWidget {
  Weather({Key? key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isLoading = false;
  setIsLoading(bool condition) {
    setState(() {
      isLoading = condition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "x",
                style: TextStyle(color: Colors.white, fontFamily: 'Comfortaa'),
              ),
              Text(
                "Weather",
                style: TextStyle(color: Colors.cyan, fontFamily: 'Comfortaa'),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            searchField(isLoading, setIsLoading),
          ],
        ),
      ),
    );
  }
}
