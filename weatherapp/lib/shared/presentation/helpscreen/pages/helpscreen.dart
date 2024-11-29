import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/core/assets/app_images.dart';

class HelpscreenPage extends StatelessWidget {
  const HelpscreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(AppImages.frame),
            fit: BoxFit.fill,
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Stack(
              children: [
                const Positioned(
                  top: 5,
                  left: 10,
                  child: Image(
                    image: AssetImage(
                      AppImages.sun,
                    ),
                    height: 145,
                    width: 145,
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 180,
                  child: Text(
                    "“We\nshow\nweather\nfor\nyou”",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Positioned(
                  bottom: 140,
                  right: 20,
                  child: Image(
                    image: AssetImage(
                      AppImages.rain,
                    ),
                    height: 145,
                    width: 145,
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 20,
                  right: 20,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.goNamed('homepage');
                    },
                    child: Column(
                      children: [
                        Text(
                          "Skip",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 50,
                  left: 30,
                  right: 30,
                  child: Text(
                    "You will be redirected to home page in 5 seconds",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
