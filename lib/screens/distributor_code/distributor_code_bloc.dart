import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/distributor_code_entity.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/service/model/call_result.dart';
import 'bloc/distributor_code_event.dart';
import 'bloc/distributor_code_state.dart';

class DistributorCodeBloc extends Bloc<DistributorCodeEvent, DistributorCodeState> {
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final TextEditingController codeTextController = TextEditingController();

  final AuthRepository authRepository;

  DistributorCodeBloc({required this.authRepository}) : super(DistributorCodeInitialState()) {
    on<DistributorCodeSubmitClickEvent>(_handleDistributorCodeSubmitClickEvent);
  }

  void _handleDistributorCodeSubmitClickEvent(
    DistributorCodeSubmitClickEvent event,
    Emitter<DistributorCodeState> emit,
  ) async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(DistributorCodeLoadingState());

      CallResult<DistributorCodeEntity> response = await authRepository.verifyDistributorCode(
        code: codeTextController.text.trim(),
      );

      if (response is Failure<DistributorCodeEntity>) {
        emit(DistributorCodeErrorState(
          error: response.cause,
          code: response.code,
        ));
      } else if (response is Success<DistributorCodeEntity>) {
        emit(DistributorCodeSuccessState(message: response.data.message));
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  @override
  Future<void> close() {
    codeTextController.dispose();
    return super.close();
  }
}
