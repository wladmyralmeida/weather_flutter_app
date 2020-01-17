import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:my_weather_app/utils/utils.dart' as utils;

class WeatherService {
  WeatherService(String city, String uf);

  static Future<Map> getWeathers(String city, String uf) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      throw SocketException("Internet indisponível.");
    }
    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city,$uf&APPID=${utils.apiKey}";
    print("> get: $url");

    final response = await http.get(url);

    return json.decode(response.body);
  }
}
