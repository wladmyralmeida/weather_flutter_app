import 'package:flutter/material.dart';
import 'package:my_weather_app/drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        appBar: AppBar(
          title: Text("Weather App"),
          centerTitle: true,
          actions: <Widget>[],
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
          ],
        ));
  }
}
