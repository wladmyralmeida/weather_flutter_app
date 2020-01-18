import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_weather_app/bloc/weather_bloc.dart';
import 'package:my_weather_app/model/weather.dart';
import 'package:my_weather_app/screens/weather/weathers_list_view.dart';
import 'package:my_weather_app/utils/event_bus.dart';
import 'package:my_weather_app/widgets/text_error_generic.dart';

class WeatherScreen extends StatefulWidget {

  final String name;

  const WeatherScreen({Key key, @required this.name}) : super(key: key);


  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with AutomaticKeepAliveClientMixin<WeatherScreen> {
  List<Weather> weathers;

  StreamSubscription<Event> subscription;

  String get name => widget.name;

  final _bloc = WeatherBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(name);

    // Escutando uma stream
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e){
      print("Event $e");
      WeatherEvent wEvent = e;
      if(wEvent.name == name) {
        _bloc.fetch(name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar o clima");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Weather> weathers = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: WeathersListView(weathers),
        );
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(name);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
    subscription.cancel();
  }
}
