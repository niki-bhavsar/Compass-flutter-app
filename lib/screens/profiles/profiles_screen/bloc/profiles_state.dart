sealed class ProfilesState {}

class ProfilesInitialState extends ProfilesState {}

class ProfilesLoadingState extends ProfilesState {}

class ProfileFetchHospitalListState extends ProfilesState {}

class ProfileFetchSurgeonListState extends ProfilesState {}

class ProfilesErrorState extends ProfilesState {
  final String error;
  final bool isAuthError;

  ProfilesErrorState({
    required this.error,
    required this.isAuthError,
  });
}
