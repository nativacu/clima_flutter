import 'package:clima/models/weather-entry.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late WeatherEntry weatherEntry;

  void loadNextScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LocationScreen(locationWeather: weatherEntry),
        )
    );
  }

  Future<void> getWeatherFromLocation() async {
    WeatherModel weatherModel = WeatherModel();
    weatherEntry = await weatherModel.getWeatherFromLocation();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getWeatherFromLocation();
      loadNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 50.0,
        ),
      )
    );
  }
}
