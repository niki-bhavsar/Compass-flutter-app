import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            Assets.appLogo,
            height: 60,
          ),
        ),
      ],
    );
  }
}
