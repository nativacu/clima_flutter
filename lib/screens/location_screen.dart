import 'package:clima/models/weather-entry.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'error_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({super.key, required this.locationWeather});

  WeatherEntry locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String weatherMessage = '';

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI({WeatherEntry? weatherData}) {
    weatherData = weatherData ?? widget.locationWeather;
    if (weatherData == null) {
      navigateToError();
      return;
    }

    setState(() {
      double temp = weatherData!.mainDetails.temperature;
      var condition = weatherData.weather.first.id;
      temperature = temp.round();
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData.name;
      weatherMessage = weather.getMessage(temperature);
    });
  }

  Future<void> updateLocation() async {
    WeatherEntry weatherData = await weather.getWeatherFromLocation();
    updateUI(weatherData: weatherData);
  }

  void onNavigationClick() async {
    var cityName = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityScreen(),
        )
    );

    if (cityName != null) {
      WeatherModel weatherModel = WeatherModel();
      WeatherEntry weatherData = await weatherModel.getWeatherFromCity(cityName);

      updateUI(weatherData: weatherData);
    }
  }

  void navigateToError() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(
              displayMessage: 'Oops Location Services were not provided. '
                  'Please enable location services through your settings'
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await updateLocation();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onNavigationClick();
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
