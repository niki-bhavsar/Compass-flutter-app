import 'package:flutter/material.dart';
import '../../widget/svg_icons.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgIcon(
            SvgIcons.appLogo,
            size: 60,
          ),
        ),
      ],
    );
  }
}
