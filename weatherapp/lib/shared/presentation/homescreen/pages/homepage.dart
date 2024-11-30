import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/core/assets/app_images.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepagebloc.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepageevent.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepagestate.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  // Handle location permission
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied. Please enable them from settings.')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.frame),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 130, 50),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                      Text(
                        'Go Back To Helpscreen',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Weather Section with Bloc
                BlocConsumer<WeatherBloc, WeatherState>(
                  listener: (context, state) {
                    if (state.error.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        // Input field for city name
                        TextField(
                          controller: cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter City Name',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Save/Update Button
                        ElevatedButton(
                          onPressed: () {
                            if (cityController.text.isNotEmpty) {
                              context
                                  .read<WeatherBloc>()
                                  .add(FetchWeather(cityController.text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please enter a valid location name'),
                                ),
                              );
                            }
                          },
                          child: Text(
                            state.locationName.isEmpty ? 'Save' : 'Update',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Weather information display
                        if (state.isLoading)
                          const CircularProgressIndicator()
                        else if (state.temperature != null)
                          Column(
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Weather Details',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Location: ${state.locationName}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Temperature: ${state.temperature}°C',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 10),

                              // Display weather icon/image if available
                              if (state.weatherIconUrl != null)
                                Image.network(
                                  'https:${state.weatherIconUrl!}', // Assuming weatherIconUrl holds the image URL
                                  width: 50,
                                  height: 50,
                                ),
                            ],
                          )
                        else
                          const Text('No weather data available.'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),

                // Floating button for current location
                ElevatedButton.icon(
                  onPressed: () async {
                    final hasPermission =
                        await _handleLocationPermission(context);
                    if (!hasPermission) return;

                    try {
                      final position = await Geolocator.getCurrentPosition();
                      context.read<WeatherBloc>().add(
                            FetchWeatherByCoordinates(
                                position.latitude, position.longitude),
                          );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to fetch current location.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text('Use Current Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
