sealed class HospitalProfileEvent {}

class HospitalsProfileFetchEvent extends HospitalProfileEvent {
  final String hospitalId;

  HospitalsProfileFetchEvent(this.hospitalId);
}
