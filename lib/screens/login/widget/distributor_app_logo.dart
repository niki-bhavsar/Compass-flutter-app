import 'package:compass_software/data/shared_pref/session_pref.dart';
import 'package:compass_software/utils/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributorAppLogo extends StatelessWidget {
  const DistributorAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200, maxHeight: 200),
        padding: const EdgeInsets.all(30.0),
        child: ImageView(
          imageUrl: context.read<SessionPref>().getDistributorInfo()?.logoUrl,
        ),
      ),
    );
  }
}
