sealed class MyProfileState {}

class MyProfileInitialState extends MyProfileState {}

class MyProfileLoadingState extends MyProfileState {}

class MyProfileFetchStatesListState extends MyProfileState {}

class MyProfileResultState extends MyProfileState {
  final String message;
  final bool isEditProfile;

  MyProfileResultState({
    required this.message,
    required this.isEditProfile,
  });
}

class MyProfileErrorState extends MyProfileState {
  final String error;
  final bool isAuthError;

  MyProfileErrorState({
    required this.error,
    required this.isAuthError,
  });
}
