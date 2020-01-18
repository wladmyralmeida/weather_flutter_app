import 'package:flutter/material.dart';
import 'package:my_weather_app/service/weather_service.dart';
import 'package:my_weather_app/api/keys.dart' as api;

class ClimateDaysScreen extends StatefulWidget {
  @override
  _ClimateDaysScreenState createState() => _ClimateDaysScreenState();
}

class _ClimateDaysScreenState extends State<ClimateDaysScreen> {
  void showWeather() async {
    var data = await WeatherService.getFiveDaysWeathers(api.defaultId);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Climates"),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center, child: fetchData(_theme, api.defaultId)),
    );
  }

  FutureBuilder<Map> fetchData(ThemeData _theme, int id) {
    return FutureBuilder(
        future: WeatherService.getFiveDaysWeathers(id),
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
                    content['city']['name'],
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: _theme.accentColor,
                    ),
                  ),
                  subtitle: Text(
                    "Latitude: \n" +
                        content['city']['coord']['lat'].toString() +
                        "\nLongitude: \n" +
                        content['city']['coord']['lon'].toString(),
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
