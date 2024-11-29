import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenevent.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenstate.dart';

class HelpScreenBloc extends HydratedBloc<HelpscreenEvent, HelpscreenState> {
  HelpScreenBloc() : super(HelpscreenInitial()) {
    on<SkipButtonPressed>((event, emit) {
      emit(NavigateToNextScreen());
    });
    on<DefaultNavigation>((event, emit) {
      emit(HelpscreenInitial());
    });
  }

  @override
  HelpscreenState? fromJson(Map<String, dynamic> json) {
    try {
      final skipped = json['skipped'] as bool?;
      return skipped == true ? NavigateToNextScreen() : HelpscreenInitial();
    } catch (_) {
      return HelpscreenInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(HelpscreenState state) {
    return {
      'skipped': state is NavigateToNextScreen,
    };
  }
}
