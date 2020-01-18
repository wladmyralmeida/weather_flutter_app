import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:my_weather_app/api/http_exception.dart';
import 'package:my_weather_app/api/keys.dart' as api;
import 'package:my_weather_app/model/forecast.dart';
import 'package:my_weather_app/model/weather.dart';

class WeatherService {
  WeatherService(String city, String uf);

  static const baseUrl = 'https://api.openweathermap.org';

  static Future<List<Weather>> getWeathers(String cityName) async {
    var url =
        '$baseUrl/data/2.5/weather?q=$cityName,uk&APPID=${api.apiKey}';
    print("GET > $url");
    var response = await http.get(url);
    if (response.statusCode != 200) {
      throw HTTPException(response.statusCode, "Não foi possível recuperar os dados sobre o clima");
    }
    String json = response.body;
    List list = convert.json.decode(json);

    List<Weather> weathers = list.map<Weather>((map) => Weather.fromMap(map)).toList();

    return weathers;
  }

  Future<List<Forecast>> getForecast(String cityName) async {
    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "Não foi possível recuperar os dados sobre o clima");
    }
    final forecastJson = convert.json.decode(res.body);
    List<Forecast> weathers = Forecast.fromForecastJson(forecastJson);
    return weathers;
  }

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "Não foi possível recuperar os dados sobre o clima");
    }
    final weatherJson = convert.json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=${api.apiKey}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "Não foi possível recuperar os dados sobre o clima");
    }
    final weatherJson = convert.json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }
}
