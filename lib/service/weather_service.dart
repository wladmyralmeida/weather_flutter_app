import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/api/http_exception.dart';
import 'package:my_weather_app/api/keys.dart' as api;
import 'package:my_weather_app/model/weather.dart';

class WeatherService {
  WeatherService(String city, String uf);

  static const baseUrl = 'http://api.openweathermap.org';

  static Future<Map> getWeathers(String city, String uf) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      throw SocketException("Internet indisponível.");
    }
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,$uf&APPID=${api.apiKey}";
    print("> get: $url");

    final response = await http.get(url);

    return json.decode(response.body);
  }

  static Future<Map> getFiveDaysWeathers(int id) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      throw SocketException("Internet indisponível.");
    }
    final url =
        "https://samples.openweathermap.org/data/2.5/forecast?id=$id&appid=${api.apiKey}";
    print("> get: $url");

    final response = await http.get(url);

    return json.decode(response.body);
  }


  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather2> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather2.fromJson(weatherJson);
  }

  Future<List<Weather2>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);
    List<Weather2> weathers = Weather2.fromForecastJson(forecastJson);
    return weathers;
  }
}
