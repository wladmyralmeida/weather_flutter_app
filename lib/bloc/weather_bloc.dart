import 'dart:async';
import 'package:my_weather_app/model/weather.dart';
import 'package:my_weather_app/screens/weather/dao/weather_dao.dart';
import 'package:my_weather_app/service/weather_service.dart';
import 'package:my_weather_app/utils/network.dart';

class WeatherBloc {
  final _streamController = StreamController<List<Weather>>();

  Stream<List<Weather>> get stream => _streamController.stream;

  Future<List<Weather>> fetch(String name) async {
    try {

      if(! await isNetworkOn()) {
        // Busca do banco de dados
        List<Weather> weather =  await WeatherDAO().findAllByCityName(name);
        if(! _streamController.isClosed) {
          _streamController.add(weather);
        }
        return weather;
      }

      List<Weather> weather = await WeatherService.getWeathers(name);

      if(weather.isNotEmpty) {
        final dao = WeatherDAO();

        // Salvar todos os weather
        weather.forEach(dao.save);
      }

      _streamController.add(weather);

      return weather;
    } catch (e) {
      if(! _streamController.isClosed) {
        _streamController.addError(e);
      }
    }
  }

  void dispose() {
    _streamController.close();
  }
}
