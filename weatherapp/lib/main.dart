import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weatherapp/core/router/approutes.dart';
import 'package:weatherapp/core/styles/app_theme.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenbloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize HydratedStorage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(
    BlocProvider(
      create: (context) => HelpScreenBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HelpScreenBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: AppTheme.lightTheme,
        routerConfig: approutes,
      ),
    );
  }
}
