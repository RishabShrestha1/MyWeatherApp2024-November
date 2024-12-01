import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenevent.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenstate.dart';

class HelpScreenBloc extends HydratedBloc<HelpscreenEvent, HelpscreenState> {
  Timer? _navigationTimer;

  HelpScreenBloc() : super(HelpscreenInitial()) {
    on<SkipButtonPressed>((event, emit) {
      _navigationTimer?.cancel();
      emit(
        NavigateToNextScreen(wasSkipped: true),
      );
    });

    on<InitializeTimer>((event, emit) {
      _navigationTimer?.cancel();
      _navigationTimer = Timer(const Duration(seconds: 5), () {
        add(TimerComplete());
      });
    });

    on<TimerComplete>((event, emit) {
      emit(NavigateToNextScreen(wasSkipped: false));
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
