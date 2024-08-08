import 'package:clima/utilities/constants.dart';
import 'package:clima/models/weather-entry.dart';
import 'package:clima/services/networking.dart';

import 'location.dart';

const apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<WeatherEntry> getWeatherEntry({required double latitude, required double longitude}) async {
    String url = '$apiUrl?lat=$latitude&lon=$longitude&appid=$kApiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper<WeatherEntry>(url);
    final weatherMap = await networkHelper.getDecodedData();
    return WeatherEntry.fromJson(weatherMap);
  }

  Future<WeatherEntry> getWeatherFromLocation() async {
    Location location = Location();
    await location.getLocation();
    return await getWeatherEntry(latitude: location.latitude, longitude: location.longitude);
  }

  Future<WeatherEntry> getWeatherFromCity(String cityName) async {
    String url = '$apiUrl?q=$cityName&appid=$kApiKey&units=metric';

    NetworkHelper networkHelper = NetworkHelper<WeatherEntry>(url);
    final weatherMap = await networkHelper.getDecodedData();
    return WeatherEntry.fromJson(weatherMap);
  }
}