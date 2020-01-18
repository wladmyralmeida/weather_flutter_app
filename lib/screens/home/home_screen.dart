import 'package:flutter/material.dart';
import 'package:my_weather_app/screens/drawer/drawer_screen.dart';
import 'package:my_weather_app/screens/forecast/forecast.dart';
import 'package:my_weather_app/screens/weather/weather_screen.dart';
import 'package:my_weather_app/utils/navigator_shortcut.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WeatherScreen(name: "Silverstone",),
      drawer: DrawerScreen(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: _onClickForecastScreen,
      ),
    );
  }

  void _onClickForecastScreen() {
    push(context, ForecastScreen());
  }
}
