abstract class HelpscreenState {}

class HelpscreenInitial extends HelpscreenState {}

class HelpscreenLoading extends HelpscreenState {}

class NavigateToNextScreen extends HelpscreenState {
  final bool wasSkipped;

  NavigateToNextScreen({required this.wasSkipped});
}
