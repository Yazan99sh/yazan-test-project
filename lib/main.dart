import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/app.dart';
import 'package:flutter_test_project/domain/core/utils/app_environment.dart';
import 'package:flutter_test_project/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureInjection(AppEnvironment.dev);
  runZonedGuarded(() {
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const App(),
      ),
    );
  }, (error, stackTrace) {
   // String time = DateTime.now().toString();
  });
}
