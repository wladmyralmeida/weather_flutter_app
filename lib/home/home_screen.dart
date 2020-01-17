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
  ThemeData _theme;

  void showWeather() async {
    Map data =
        await getWeather(utils.apiKey, utils.defaultCity, utils.defaultUf);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);

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
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: Image.asset("assets/images/clouds.png"),
            ),
            Container(
              alignment: Alignment.center,
              child: updateTempWidget("London", "uk"),
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

  Widget updateTempWidget(String city, String uf) {
    return FutureBuilder(
        future: getWeather(utils.apiKey, city, uf),
        builder: (context, AsyncSnapshot<Map> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 40,
              width: 40,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          Map content = snapshot.data;
          return Container(
            margin: EdgeInsets.only(left: 8.0, top: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    content['name'],
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: _theme.accentColor,
                    ),
                  ),
                  subtitle: Text(
                    content['main']['temp'].toString() + " °F",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: _theme.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
