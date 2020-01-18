import 'package:flutter/material.dart';
import 'package:my_weather_app/model/weather.dart';
import 'package:my_weather_app/screens/forecast/forecast.dart';
import 'package:my_weather_app/utils/navigator_shortcut.dart';

class WeathersListView extends StatelessWidget {
  List<Weather> weathers;

  WeathersListView(this.weathers);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: weathers.length,
        itemBuilder: (context, index) {
          Weather w = weathers[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 50.0,
                      child: Icon(w.getIconData() ?? Icons.ac_unit),
                    ),
                  ),
                  Text(
                    w.cityName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    w.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    // make buttons use the appropriate styles for cards
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickWeather(context, weathers),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickWeather(context, List<Weather> w) {
    push(context, ForecastScreen(weathers: w,));
  }
}
