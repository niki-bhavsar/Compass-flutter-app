import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/service/model/call_result.dart';
import '../../data/entity/change_password_entity.dart';
import '../../data/repository/my_profile_repository.dart';
import 'bloc/change_password_event.dart';
import 'bloc/change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final MyProfileRepository myProfileRepository;

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  ChangePasswordBloc({required this.myProfileRepository}) : super(ChangePasswordInitialState()) {
    on<ChangePasswordUpdateEvent>(_handleChangePasswordEvent);
  }

  _handleChangePasswordEvent(
    ChangePasswordUpdateEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(ChangePasswordLoadingState());

      final result = await myProfileRepository.changePassword(
          currentPasswordController.text, newPasswordController.text);
      if (result is Success<ChangePasswordEntity>) {
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();
        autoValidateMode = AutovalidateMode.disabled;
        emit(ChangePasswordResultState(result.data));
      } else if (result is Failure<ChangePasswordEntity>) {
        final error = ChangePasswordErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        );
        emit(error);
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
