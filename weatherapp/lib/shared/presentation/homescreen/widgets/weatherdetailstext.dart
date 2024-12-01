import 'package:flutter/material.dart';

class WeatherDetailsText extends StatelessWidget {
  final String titletext;
  final String detailstext;
  const WeatherDetailsText(
      {super.key, required this.titletext, required this.detailstext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$titletext: ',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          detailstext,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
