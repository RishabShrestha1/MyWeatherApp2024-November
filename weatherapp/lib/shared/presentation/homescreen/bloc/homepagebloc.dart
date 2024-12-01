import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp/features/datasources/weatherdatacontroller.dart';

import './homepageevent.dart';
import './homepagestate.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherDataController weatherController;

  WeatherBloc(this.weatherController) : super(const WeatherState()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherByCoordinates>(_onFetchWeatherByCoordinates);
    on<AutoFetchWeather>(_onAutoFetchWeather);
  }

  Future<void> _onFetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final weather = await weatherController.getWeatherData(event.location);
      emit(state.copyWith(
        locationName: event.location,
        temperature: weather.current.tempC,
        weatherIconUrl: weather.current.condition.icon,
        isLoading: false,
        weatherConditions: weather.current.condition.text,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load weather'));
    }
  }

  Future<void> _onFetchWeatherByCoordinates(
      FetchWeatherByCoordinates event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      final location = '${event.latitude},${event.longitude}';
      final weather = await weatherController.getWeatherData(location);
      emit(state.copyWith(
          locationName: 'Current Location',
          temperature: weather.current.tempC,
          weatherIconUrl: weather.current.condition.icon,
          weatherConditions: weather.current.condition.text,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load weather'));
    }
  }

  Future<void> _onAutoFetchWeather(
      AutoFetchWeather event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services are disabled.');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            'Location permissions are permanently denied. Enable them from settings.');
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      add(FetchWeatherByCoordinates(position.latitude, position.longitude));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState(
      locationName: json['locationName'] ?? '',
      temperature: json['temperature'],
      weatherIconUrl: json['weatherIconUrl'],
      weatherConditions: json['weatherConditions'],
    );
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return {
      'locationName': state.locationName,
      'temperature': state.temperature,
      'weatherIconUrl': state.weatherIconUrl,
      'weatherConditions': state.weatherConditions,
    };
  }
}
