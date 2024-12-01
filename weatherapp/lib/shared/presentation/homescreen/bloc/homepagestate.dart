import 'package:equatable/equatable.dart';

class WeatherState extends Equatable {
  final String locationName;
  final double? temperature;
  final bool isLoading;
  final String error;
  final String? weatherConditions;
  final String? weatherIconUrl;

  const WeatherState(
      {this.locationName = '',
      this.temperature,
      this.isLoading = false,
      this.error = '',
      this.weatherIconUrl,
      this.weatherConditions});

  WeatherState copyWith({
    String? locationName,
    double? temperature,
    bool? isLoading,
    String? error,
    String? weatherIconUrl,
    String? weatherConditions,
  }) {
    return WeatherState(
      locationName: locationName ?? this.locationName,
      temperature: temperature,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      weatherIconUrl: weatherIconUrl ?? this.weatherIconUrl,
      weatherConditions: weatherConditions ?? this.weatherConditions,
    );
  }

  @override
  List<Object?> get props => [
        locationName,
        temperature,
        isLoading,
        error,
        weatherIconUrl,
        weatherConditions
      ];
}
