import 'package:compass_software/data/entity/change_password_entity.dart';

sealed class ChangePasswordState {}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordResultState extends ChangePasswordState {
  final ChangePasswordEntity changePasswordEntity;

  ChangePasswordResultState(this.changePasswordEntity);
}

class ChangePasswordErrorState extends ChangePasswordState {
  final String error;
  final bool isAuthError;

  ChangePasswordErrorState({
    required this.error,
    required this.isAuthError,
  });
}
