import 'package:compass_software/theme/assets.dart';
import 'package:flutter/material.dart';

class SplashAppLogo extends StatelessWidget {
  const SplashAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(120.0),
        child: const Image(image: AssetImage(Assets.appIcon)),
      ),
    );
  }
}
