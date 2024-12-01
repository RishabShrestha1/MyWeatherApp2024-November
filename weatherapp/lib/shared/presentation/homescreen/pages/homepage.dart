import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/core/assets/app_images.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepagebloc.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepageevent.dart';
import 'package:weatherapp/shared/presentation/homescreen/bloc/homepagestate.dart';
import 'package:weatherapp/shared/presentation/homescreen/widgets/weatherdetailstext.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context
                      .go('/helppage', extra: {'intentionalNavigation': true});
                },
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              const Text(
                'Go Back To Helpscreen',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.frame),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocConsumer<WeatherBloc, WeatherState>(
                    listener: (context, state) {
                      if (state.error.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.locationName.isEmpty && !state.isLoading) {
                        context.read<WeatherBloc>().add(AutoFetchWeather());
                      }
                      return Column(
                        children: [
                          // Weather information display
                          if (state.isLoading)
                            const CircularProgressIndicator()
                          else if (state.temperature != null)
                            Column(
                              children: [
                                // Display weather icon/image if available
                                if (state.weatherIconUrl != null)
                                  //Weather Icon
                                  Card(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                        side: BorderSide(
                                          color: Colors.black,
                                        )),
                                    child: Image.network(
                                      'https:${state.weatherIconUrl!}',
                                      width: 210,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.error,
                                          color: Colors.red,
                                          size: 50,
                                        );
                                      },
                                    ),
                                  ),
                                const SizedBox(height: 40),
                                const Text(
                                  'Weather Details',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //Weather Details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WeatherDetailsText(
                                      titletext: 'Location',
                                      detailstext: state.locationName,
                                    ),
                                    const SizedBox(height: 10),
                                    WeatherDetailsText(
                                      titletext: 'Weather Conditions',
                                      detailstext:
                                          state.weatherConditions.toString(),
                                    ),
                                    const SizedBox(height: 10),
                                    WeatherDetailsText(
                                      titletext: 'Temperature',
                                      detailstext:
                                          '${state.temperature.toString()}°C',
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            )
                          else
                            const Text('No weather data available.'),
                          const SizedBox(height: 20),
                          // City name textfield
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 80,
                            child: TextField(
                              controller: cityController,
                              onSubmitted: (value) {
                                log('City Name: $value');
                                context.read<WeatherBloc>().add(
                                      FetchWeather(value),
                                    );
                              },
                              decoration: InputDecoration(
                                hintText:
                                    state.locationName == 'Current Location' ||
                                            state.locationName.isNotEmpty
                                        ? state.locationName
                                        : 'Enter City Name',
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Save/Update Button
                          ElevatedButton(
                            onPressed: () {
                              if (cityController.text.isNotEmpty) {
                                context.read<WeatherBloc>().add(
                                      FetchWeather(cityController.text),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please enter a valid location name'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width - 80, 50),
                            ),
                            child: Text(
                              state.locationName.isEmpty ||
                                      state.locationName == 'Current Location'
                                  ? 'Save'
                                  : 'Update',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
