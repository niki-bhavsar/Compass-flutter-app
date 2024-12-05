sealed class DistributorCodeState {}

class DistributorCodeInitialState extends DistributorCodeState {}

class DistributorCodeLoadingState extends DistributorCodeState {}

class DistributorCodeSuccessState extends DistributorCodeState {
  final String? message;

  DistributorCodeSuccessState({
    required this.message,
  });
}

class DistributorCodeErrorState extends DistributorCodeState {
  final String error;
  final int code;

  DistributorCodeErrorState({
    required this.error,
    required this.code,
  });
}
