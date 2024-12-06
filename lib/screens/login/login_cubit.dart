import 'package:compass_software/data/entity/login_entity.dart';
import 'package:compass_software/data/repository/auth_repository.dart';
import 'package:compass_software/data/service/model/call_result.dart';
import 'package:compass_software/screens/login/state/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitialState());

  void handleLoginClickEvent() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(LoginLoadingState());
      final username = usernameTextController.text.trim();
      final password = passwordTextController.text.trim();

      CallResult<LoginEntity> response = await authRepository.login(
        username: username,
        password: password,
      );

      if (response is Failure<LoginEntity>) {
        emit(LoginErrorState(
          error: response.cause,
          code: response.code,
        ));
      } else if (response is Success<LoginEntity>) {
        emit(LoginSuccessState(
          message: response.data.message,
        ));
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  @override
  Future<void> close() {
    usernameTextController.dispose();
    passwordTextController.dispose();
    return super.close();
  }
}
