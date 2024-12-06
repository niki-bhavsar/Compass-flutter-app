sealed class SettingState {}

class SettingInitialState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingLogoutState extends SettingState {
  final String? message;

  SettingLogoutState({
    required this.message,
  });
}

class SettingErrorState extends SettingState {
  final String error;
  final int code;

  SettingErrorState({
    required this.error,
    required this.code,
  });
}
