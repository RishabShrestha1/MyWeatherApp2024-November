import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenevent.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenstate.dart';

class HelpScreenBloc extends HydratedBloc<HelpscreenEvent, HelpscreenState> {
  Timer? _navigationTimer;

  HelpScreenBloc() : super(HelpscreenInitial()) {
    // Handle manual skip button press
    on<SkipButtonPressed>((event, emit) {
      _navigationTimer?.cancel(); // Cancel any existing timer
      emit(NavigateToNextScreen(
          wasSkipped: true)); // Mark that this was a manual skip
    });

    // Handle timer initialization
    on<InitializeTimer>((event, emit) {
      _navigationTimer?.cancel(); // Ensure we don't have multiple timers
      _navigationTimer = Timer(const Duration(seconds: 5), () {
        // When timer completes, navigate but don't mark as skipped
        add(TimerComplete());
      });
    });

    // Handle timer completion
    on<TimerComplete>((event, emit) {
      emit(NavigateToNextScreen(wasSkipped: false)); // Not marked as skipped
    });
  }

  @override
  Future<void> close() {
    _navigationTimer?.cancel();
    return super.close();
  }

  @override
  HelpscreenState? fromJson(Map<String, dynamic> json) {
    try {
      final wasSkipped = json['was_skipped'] as bool?;
      // Only return NavigateToNextScreen if it was explicitly skipped
      return wasSkipped == true
          ? NavigateToNextScreen(wasSkipped: true)
          : HelpscreenInitial();
    } catch (_) {
      return HelpscreenInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(HelpscreenState state) {
    if (state is NavigateToNextScreen) {
      // Only persist the state if it was manually skipped
      return {'was_skipped': state.wasSkipped};
    }
    return {'was_skipped': false};
  }
}
