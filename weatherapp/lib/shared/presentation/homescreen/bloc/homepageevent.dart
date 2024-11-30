abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String location;

  FetchWeather(this.location);
}

class FetchWeatherByCoordinates extends WeatherEvent {
  final double latitude;
  final double longitude;

  FetchWeatherByCoordinates(this.latitude, this.longitude);
}
