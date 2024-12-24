import 'package:compass_software/data/entity/base_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/entity/hospital_contact_entity.dart';
import '../../../data/repository/profiles_repository.dart';
import '../../../data/service/model/call_result.dart';
import 'bloc/hospital_contacts_state.dart';

class HospitalContactsCubit extends Cubit<HospitalContactsState> {
  final ProfilesRepository profilesRepository;
  final String hospitalId;

  List<HospitalContact> hospitalContactsList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  HospitalContactsCubit({
    required this.profilesRepository,
    required this.hospitalId,
  }) : super(HospitalContactsInitialState());

  getHospitalContacts() async {
    emit(HospitalContactsLoadingState());

    final result = await profilesRepository.getHospitalContacts(hospitalId);
    if (result is Failure<HospitalContactEntity>) {
      emit(HospitalContactsErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<HospitalContactEntity>) {
      hospitalContactsList.clear();
      hospitalContactsList.addAll(result.data.hospitalContacts);
      emit(HospitalContactsListResultState());
    }
  }

  addHospitalContacts() async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(HospitalContactsLoadingState());

      final result = await profilesRepository.addHospitalContacts(
        hospitalId: hospitalId,
        name: nameController.text,
        email: emailController.text,
      );
      if (result is Failure<BaseEntity>) {
        emit(HospitalContactsErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ));
      } else if (result is Success<BaseEntity>) {
        nameController.clear();
        emailController.clear();
        emit(AddHospitalContactsResultState());
        getHospitalContacts();
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }

  deleteHospitalContacts(String contactId) async {
    emit(HospitalContactsLoadingState());

    final result = await profilesRepository.deleteHospitalContacts(
      hospitalId: hospitalId,
      contactId: contactId,
    );

    if (result is Failure<BaseEntity>) {
      emit(HospitalContactsErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<BaseEntity>) {
      emit(DeleteHospitalContactsResultState());
      getHospitalContacts();
    }
  }
}
