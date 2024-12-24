import 'package:compass_software/data/entity/state_entity.dart';
import 'package:compass_software/data/entity/user_profile_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/base_entity.dart';
import '../../data/repository/my_profile_repository.dart';
import '../../data/service/model/call_result.dart';
import 'bloc/my_profile_event.dart';
import 'bloc/my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final MyProfileRepository myProfileRepository;
  List<StatesList> statesList = [];
  StatesList? selectedState;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController wwidController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController cellNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController faxNumberController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController contactInfoController = TextEditingController();

  MyProfileBloc({
    required this.myProfileRepository,
  }) : super(MyProfileInitialState()) {
    on<StateListFetchEvent>(_handleStateListFetchEvent);
    on<UserProfileFetchEvent>(_handleUserProfileFetchEvent);
    on<UserProfileSaveEvent>(_handleUserProfileSaveEvent);
  }

  _handleStateListFetchEvent(
    StateListFetchEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(MyProfileLoadingState());

    final result = await myProfileRepository.getStateList();
    if (result is Failure<StateEntity>) {
      emit(MyProfileErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<StateEntity>) {
      statesList.clear();
      statesList.addAll(result.data.states.toList());

      emit(MyProfileFetchStatesListState());
    }
  }

  _handleUserProfileFetchEvent(
    UserProfileFetchEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(MyProfileLoadingState());

    final result = await myProfileRepository.getRepUserProfile();
    if (result is Failure<UserProfileEntity>) {
      emit(MyProfileErrorState(
        error: result.cause,
        isAuthError: result.isAuthError(),
      ));
    } else if (result is Success<UserProfileEntity>) {
      UserProfileInfo? user = result.data.userProfileInfo;
      userNameController.text = user.login;
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      groupController.text = user.group;
      emailController.text = user.email;
      wwidController.text = user.wwId;
      addressController.text = "${user.addressLine1}\n${user.addressLine2}";
      cityController.text = user.city;
      if (user.state == "") {
        selectedState = statesList.first;
      } else {
        selectedState = statesList.firstWhere((st) => st.name == user.state);
      }
      zipController.text = user.zipCode;
      cellNumberController.text = user.cellNumber;
      phoneNumberController.text = user.phoneNumber;
      faxNumberController.text = user.faxNumber;
      accountNumberController.text = user.accountNumber;
      contactInfoController.text = user.contactInfo;

      emit(MyProfileResultState(
        message: result.data.message,
        isEditProfile: false,
      ));
    }
  }

  _handleUserProfileSaveEvent(
    UserProfileSaveEvent event,
    Emitter<MyProfileState> emit,
  ) async {
    final isValidForm = formKey.currentState?.validate() ?? false;
    if (isValidForm) {
      emit(MyProfileLoadingState());

      final result = await myProfileRepository.saveRepUserProfile(
        address1: addressController.text,
        address2: addressController.text,
        city: cityController.text,
        state: selectedState?.name ?? "",
        zip: zipController.text,
        cellNumber: cellNumberController.text,
        phoneNumber: phoneNumberController.text,
        faxNumber: faxNumberController.text,
        accountNumber: accountNumberController.text,
        contactInfo: contactInfoController.text,
      );

      if (result is Failure<BaseEntity>) {
        emit(MyProfileErrorState(
          error: result.cause,
          isAuthError: result.isAuthError(),
        ));
      } else if (result is Success<BaseEntity>) {
        emit(MyProfileResultState(
          message: result.data.message,
          isEditProfile: true,
        ));
      }
    } else {
      autoValidateMode = AutovalidateMode.always;
    }
  }
}
