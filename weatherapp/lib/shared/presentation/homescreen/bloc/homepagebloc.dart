// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:weatherapp/features/datasources/weatherdatacontroller.dart';

// import './homepageevent.dart';
// import './homepagestate.dart';

// class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
//   final WeatherDataController weatherController;

//   WeatherBloc(this.weatherController) : super(const WeatherState()) {
//     on<FetchWeather>(_onFetchWeather);
//     on<FetchWeatherByCoordinates>(_onFetchWeatherByCoordinates);
//   }

//   Future<void> _onFetchWeather(
//       FetchWeather event, Emitter<WeatherState> emit) async {
//     emit(state.copyWith(isLoading: true, error: ''));
//     try {
//       final weather = await weatherController.getWeatherData(event.location);
//       emit(state.copyWith(
//           locationName: event.location,
//           temperature: weather.current.tempC,
//           isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, error: 'Failed to load weather'));
//     }
//   }

//   Future<void> _onFetchWeatherByCoordinates(
//       FetchWeatherByCoordinates event, Emitter<WeatherState> emit) async {
//     emit(state.copyWith(isLoading: true, error: ''));
//     try {
//       final location = '${event.latitude},${event.longitude}';
//       final weather = await weatherController.getWeatherData(location);
//       emit(state.copyWith(
//           locationName: '',
//           temperature: weather.current.tempC,
//           isLoading: false));
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, error: 'Failed to load weather'));
//     }
//   }

//   @override
//   WeatherState? fromJson(Map<String, dynamic> json) {
//     return WeatherState(
//       locationName: json['locationName'] ?? '',
//       temperature: json['temperature'],
//     );
//   }

//   @override
//   Map<String, dynamic>? toJson(WeatherState state) {
//     return {
//       'locationName': state.locationName,
//       'temperature': state.temperature,
//     };
//   }
// }
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp/features/datasources/weatherdatacontroller.dart';

import './homepageevent.dart';
import './homepagestate.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  final WeatherDataController weatherController;

  WeatherBloc(this.weatherController) : super(const WeatherState()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherByCoordinates>(_onFetchWeatherByCoordinates);
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
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load weather'));
    }
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    return WeatherState(
      locationName: json['locationName'] ?? '',
      temperature: json['temperature'],
      weatherIconUrl: json['weatherIconUrl'],
    );
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
    return {
      'locationName': state.locationName,
      'temperature': state.temperature,
      'weatherIconUrl': state.weatherIconUrl,
    };
  }
}
