import 'package:flutter/material.dart';

class SurgeonProfileEventsView extends StatelessWidget {
  const SurgeonProfileEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //TODO: Once Events Data will be there from api then we will work on it
      child: Text("No Data"),
    );
  }
}
