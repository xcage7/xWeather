import "package:flutter/material.dart";

Widget detailBody(info) {
  return Container(
    margin: EdgeInsets.all(15),
    child: Column(
      children: [
        Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: info["icon"],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "${info['description']}",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Comfortaa",
                  ),
                ),
              ),
              Container(
                child: Text(
                  "${info['city']}",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Comfortaa",
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
                  "Country : ${info['country']}",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Temprature : ${info['temp']} \u00B0c",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Wind : ${info['wind']} km/hr",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Humidity : ${info['humidity']} %",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Latitude : ${info['lat']} \u00B0",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Longitude : ${info['lon']} \u00B0",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Temp Min : ${info['tempMin']} \u00B0c",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Temp Max : ${info['tempMax']} \u00B0c",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
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
                  "Sea Level : ${info['seaLevel']} m",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
