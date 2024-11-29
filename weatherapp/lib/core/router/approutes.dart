import 'package:go_router/go_router.dart';
import 'package:weatherapp/shared/presentation/helpscreen/pages/helpscreen.dart';
import 'package:weatherapp/shared/presentation/homescreen/pages/homepage.dart';

final approutes = GoRouter(
  initialLocation: '/helppage',
  routes: [
    GoRoute(
      path: '/helppage',
      name: 'helppage',
      builder: (context, state) => const HelpscreenPage(),
    ),
    GoRoute(
      path: '/homepage',
      name: 'homepage',
      builder: (context, state) => const Homepage(),
    ),
  ],
);
