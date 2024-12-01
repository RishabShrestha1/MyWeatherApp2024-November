import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weatherapp/core/constants/apiconst.dart';
import 'package:weatherapp/features/model/weatherdatamodel.dart';

class WeatherDataController {
  Future<WeatherDataFromApi> getWeatherData(String city) async {
    ApiConsts apiConsts = ApiConsts();
    String url = apiConsts.baseUrl + city;
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log('Response: ${response.body}');

      return WeatherDataFromApi.fromJson(jsonDecode(response.body));
    } else {
      log('Response: ${response.body}');
      throw Exception('Failed to load weather data');
    }
  }
}
