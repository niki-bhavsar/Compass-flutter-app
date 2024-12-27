sealed class SurgeonProfileEvent {}

class SurgeonProfileFetchEvent extends SurgeonProfileEvent {
  final String surgeonID;

  SurgeonProfileFetchEvent(this.surgeonID);
}

class SurgeonProfileEventsFetch extends SurgeonProfileEvent {
  final String surgeonID;

  SurgeonProfileEventsFetch(this.surgeonID);
}
