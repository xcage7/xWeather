import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xweather/files/detail.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _searchValue = '';

Widget searchField(isLoading, setIsLoading) {
  return Form(
    key: _formKey,
    child: Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(3),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search_rounded),
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Field Can\'t Be Empty';
              }
            },
            onChanged: (value) => _searchValue = value,
          ),
          LayoutBuilder(
            builder: (BuildContext context, _) {
              return x(isLoading, setIsLoading, context);
            },
          ),
        ],
      ),
    ),
  );
}

getWeather(String searchValue) async {
  try {
    var response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?q=$searchValue&appid=87edfe8fa9d769d1fdc98d83269a9b9b&units=metric');
    var result = response.data;

    var city = result['name'];
    var description = result['weather'][0]['main'];
    var country = result['sys']['country'];
    var temp = result['main']['temp'];
    var wind = result['wind']['speed'] + 0.0;
    var humidity = result['main']['humidity'] + 0.0;
    var tempMin = result['main']['temp_min'];
    var tempMax = result['main']['temp_max'];
    var seaLevel;
    if (result['main']['sea_level'] != null) {
      seaLevel = result['main']['sea_level'] + 0.0;
    } else {
      seaLevel = 0.0;
    }
    var lon = result['coord']['lon'];
    var lat = result['coord']['lat'];
    var iconSrc = result['weather'][0]['icon'];
    // var icon =
    //     Image.network('https://openweathermap.org/img/wn/$iconSrc@2x.png');
    var icon = FadeInImage.assetNetwork(
      placeholder: 'icon/loading.ico',
      image: 'https://openweathermap.org/img/wn/$iconSrc@2x.png',
      fadeOutCurve: Curves.fastOutSlowIn,

    );

    return {
      'result': 'success',
      'city': city,
      'description': description,
      'country': country,
      'temp': temp,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'wind': wind,
      'humidity': humidity,
      'seaLevel': seaLevel,
      'lon': lon,
      'lat': lat,
      'icon': icon,
    };
    // ignore: unused_catch_clause
  } on DioError catch (e) {
    return {'result': 'failed'};
  }
}

Widget x(bool isLoading, setIsLoading, context) {
  if (isLoading) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: LinearProgressIndicator(),
    );
  } else {
    return OutlinedButton(
      onPressed: () async {
        setIsLoading(true);
        if (_formKey.currentState!.validate()) {
          var info = await getWeather(_searchValue);
          if (info['result'] == 'success') {
            setIsLoading(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Detail(info: info),
              ),
            );
          } else if (info['result'] == 'failed') {
            setIsLoading(false);
            final snackBar = SnackBar(
              content: Text(
                'Request Failed. Please Try Again!',
                textAlign: TextAlign.center,
              ),
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: Text('search'),
    );
  }
}
