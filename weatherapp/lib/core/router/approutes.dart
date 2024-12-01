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
      // Only redirect if this is the initial app launch and help screen was skipped
      if (navigateState.wasSkipped &&
          state.uri.toString() == '/helppage' &&
          !state.extra.toString().contains('intentionalNavigation')) {
        return '/homepage';
      }
    }
    return null;
  },
);
