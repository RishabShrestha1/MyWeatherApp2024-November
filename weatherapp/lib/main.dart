import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:weatherapp/core/router/approutes.dart';
import 'package:weatherapp/core/styles/app_theme.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      routerConfig: approutes,
    );
  }
}
