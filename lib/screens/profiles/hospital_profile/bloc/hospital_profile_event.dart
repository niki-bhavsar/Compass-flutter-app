sealed class HospitalProfileEvent {}

class HospitalsProfileFetchEvent extends HospitalProfileEvent {
  final String hospitalId;

  HospitalsProfileFetchEvent(this.hospitalId);
}

class HospitalNotesFetchEvent extends HospitalProfileEvent {
  final String hospitalId;
  HospitalNotesFetchEvent(this.hospitalId);
}
