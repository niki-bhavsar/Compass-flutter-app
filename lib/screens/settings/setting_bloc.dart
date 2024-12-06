import 'package:compass_software/data/entity/base_entity.dart';
import 'package:compass_software/screens/settings/state/setting_event.dart';
import 'package:compass_software/screens/settings/state/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/service/model/call_result.dart';


class SettingBloc extends Bloc<SettingEvent, SettingState> {

  final AuthRepository authRepository;

  SettingBloc({required this.authRepository}) : super(SettingInitialState()) {
    on<SettingLogoutClickEvent>(_handleLogoutClickEvent);
  }

  void _handleLogoutClickEvent(
      SettingLogoutClickEvent event,
      Emitter<SettingState> emit,
      ) async {
      emit(SettingLoadingState());

      CallResult<BaseEntity> response = await authRepository.logout();

      if (response is Failure<BaseEntity>) {
        emit(SettingErrorState(
          error: response.cause,
          code: response.code,
        ));
      } else if (response is Success<BaseEntity>) {
        emit(SettingLogoutState(message: response.data.message));
      }
    }

}
