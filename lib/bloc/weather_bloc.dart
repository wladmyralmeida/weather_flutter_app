import 'dart:async';
import 'package:my_weather_app/service/weather_service.dart';

class WeatherBloc {
  final _controller = StreamController();

  get stream => _controller.stream;

  Future fetch(String city, String uf) {
    // Web Service
    return WeatherService.getWeathers(city, uf).then((weather) {
      _controller.sink.add(weather);
    }).catchError((error) {
      _controller.addError(error);
    });
  }

  void close() {
    _controller.close();
  }
}
