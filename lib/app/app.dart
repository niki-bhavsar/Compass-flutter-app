import 'package:compass_software/screens/splash/splash_screen.dart';
import 'package:compass_software/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompassRepApp extends StatelessWidget {
  const CompassRepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compass Software',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
