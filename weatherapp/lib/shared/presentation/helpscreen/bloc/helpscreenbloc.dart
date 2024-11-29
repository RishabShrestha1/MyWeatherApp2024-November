import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenevent.dart';
import 'package:weatherapp/shared/presentation/helpscreen/bloc/helpscreenstate.dart';

class HelpScreenBloc extends Bloc<Helpscreenevent, Helpscreenstate> {
  HelpScreenBloc() : super(HelpscreenInital()) {
    on<SkipButtonPressed>(onSkipButtonPressed);
  }
}

void onSkipButtonPressed(
    SkipButtonPressed event, Emitter<Helpscreenstate> emit) {}
