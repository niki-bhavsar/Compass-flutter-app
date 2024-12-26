sealed class SurgeonProfileEvent {}

class SurgeonProfileFetchEvent extends SurgeonProfileEvent {
  final String surgeonID;

  SurgeonProfileFetchEvent(this.surgeonID);
}
