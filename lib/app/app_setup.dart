import 'package:compass_software/di/di_modules.dart';
import 'package:compass_software/firebase/analytics.dart';
import 'package:compass_software/firebase/crashlytics.dart';
import 'package:compass_software/firebase/performance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

final appSetup = AppSetup();

class AppSetup {
  Future preLaunchSetup() async {
    await registerGetItModules();

    await dotenv.load(fileName: ".env");

    _setOrientations();

    _setupLogging();
     _setupFirebase();
  }

  Future postLaunchSetup() async {
    // await _setupFirebase();
    await _postSetupDeviceLocaleConfig();
  }

  // Set portrait mode only
  _setOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  _setupLogging() {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  }

  /// Setup Firebase and Crashlytics
  _setupFirebase() async {
    await Firebase.initializeApp();
    await Crashlytics.instance.setCrashlyticsCollectionEnabled();
    await Performance.instance.setPerformanceCollectionEnabled();
    await Analytics.instance.setAnalyticsCollectionEnabled();
  }

  /// Set device locale for date-time formatting
  _postSetupDeviceLocaleConfig() async {
    Intl.defaultLocale = "en";
    await initializeDateFormatting("en");
  }
}
