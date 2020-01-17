import 'package:flutter/material.dart';
import 'package:my_weather_app/drawer/drawer_screen.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/utils/utils.dart' as utils;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showWeather() async {
    Map data =
        await getWeather(utils.apiKey, utils.defaultCity, utils.defaultUf);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        appBar: AppBar(
          title: Text("Weather App"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: showWeather)
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/home_background.jpg",
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 16.0, top: 64.0),
              child: Text("Current City", style: styleCurrentCity(_theme)),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: Image.asset("assets/images/clouds.png"),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "50.9º F",
                style: styleClimate(_theme),
              ),
            ),
          ],
        ));
  }

  Future<Map> getWeather(String apiKey, String city, String uf) async {
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,$uf&APPID=${utils.apiKey}";

    http.Response response = await http.get(apiUrl);
    return json.decode(response.body);
  }

  TextStyle styleClimate(ThemeData _theme) => TextStyle(
      color: _theme.accentColor, fontWeight: FontWeight.bold, fontSize: 40.0);

  TextStyle styleCurrentCity(ThemeData _theme) {
    return TextStyle(
        fontSize: 24.0,
        color: _theme.accentColor,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold);
  }
}
