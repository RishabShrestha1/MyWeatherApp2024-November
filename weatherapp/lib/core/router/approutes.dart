import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenbloc.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenstate.dart';
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
  redirect: (context, state) {
    final bloc = context.read<HelpScreenBloc>();
    if (bloc.state is NavigateToNextScreen) {
      final navigateState = bloc.state as NavigateToNextScreen;
      if (navigateState.wasSkipped && state.uri.toString() == '/helppage') {
        return '/homepage';
      }
    }
    return null;
  },
);
