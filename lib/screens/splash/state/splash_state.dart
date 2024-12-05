sealed class SplashState {}

class SplashInitialState extends SplashState {}

class SplashFetchedState extends SplashState {
  final bool isLoggedIn;
  final bool isDistributorSaved;

  SplashFetchedState({
    required this.isLoggedIn,
    required this.isDistributorSaved,
  });
}
