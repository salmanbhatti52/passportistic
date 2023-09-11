import 'package:bloc/bloc.dart';

// Events
enum OnboardingEvent { showOnboarding, hideOnboarding }

// States
enum OnboardingState { showing, hidden }

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.hidden);

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    if (event == OnboardingEvent.showOnboarding) {
      yield OnboardingState.showing;
    } else if (event == OnboardingEvent.hideOnboarding) {
      yield OnboardingState.hidden;
    }
  }
}
