import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/core/routing/app_router.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/services/app_settings_provider.dart';
import 'package:medishield_ai/core/services/preferences_service.dart';
import 'package:medishield_ai/core/services/report_provider.dart';
import 'package:medishield_ai/core/services/scan_history_provider.dart';
import 'package:medishield_ai/core/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferencesService = PreferencesService();
  final themeProvider = ThemeProvider(preferencesService);
  final appSettingsProvider = AppSettingsProvider(preferencesService);
  final scanHistoryProvider = ScanHistoryProvider(preferencesService);
  final reportProvider = ReportProvider(preferencesService);

  await Future.wait([
    themeProvider.initialize(),
    appSettingsProvider.initialize(),
    scanHistoryProvider.initialize(),
    reportProvider.initialize(),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<AppSettingsProvider>.value(
          value: appSettingsProvider,
        ),
        ChangeNotifierProvider<ScanHistoryProvider>.value(
          value: scanHistoryProvider,
        ),
        ChangeNotifierProvider<ReportProvider>.value(value: reportProvider),
      ],
      child: const MediShieldApp(),
    ),
  );
}

class MediShieldApp extends StatelessWidget {
  const MediShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
