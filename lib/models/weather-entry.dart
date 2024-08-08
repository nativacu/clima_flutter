import 'dart:convert';

class WeatherEntry {
  final String name;
  final List<WeatherDetails> weather;
  final MainWeatherDetails mainDetails;

  const WeatherEntry({
    required this.name,
    required this.weather,
    required this.mainDetails
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
        name: json['name'] as String,
        weather: (json['weather'] as List).map((i) => WeatherDetails.fromJson(i)).toList(),
        mainDetails: MainWeatherDetails.fromJson(json['main'])
    );
  }
}

class WeatherDetails {
  final String description;
  final String icon;
  final int id;
  final String main;

  const WeatherDetails({
    required this.description,
    required this.icon,
    required this.id,
    required this.main,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      description: json['description'] as String,
      icon: json['icon'] as String,
      id: json['id'] as int,
      main: json['main'] as String
    );
  }
}

class MainWeatherDetails {
  final double temperature;

  const MainWeatherDetails({
    required this.temperature
  });

  factory MainWeatherDetails.fromJson(Map<String, dynamic> json) {
    return MainWeatherDetails(temperature: json['temp'] as double);
  }
}
