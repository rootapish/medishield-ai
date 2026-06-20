import 'package:flutter/material.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/features/about/about_screen.dart';
import 'package:medishield_ai/features/ai_analysis/ai_analysis_screen.dart';
import 'package:medishield_ai/features/home/home_screen.dart';
import 'package:medishield_ai/features/reports/reports_screen.dart';
import 'package:medishield_ai/features/risk_map/risk_map_screen.dart';
import 'package:medishield_ai/features/scanner/barcode_scanner_view.dart';
import 'package:medishield_ai/features/scanner/scanner_screen.dart';
import 'package:medishield_ai/features/offline/offline_screen.dart';
import 'package:medishield_ai/features/settings/settings_screen.dart';
import 'package:medishield_ai/features/verification/verification_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _materialRoute(settings, const HomeScreen());
      case AppRoutes.scan:
        return _materialRoute(settings, const ScannerScreen());
      case AppRoutes.verify:
        final args = settings.arguments;
        final batchCode = args is VerifyRouteArgs ? args.batchCode : null;
        return _materialRoute(
          settings,
          VerificationScreen(initialBatchCode: batchCode),
        );
      case AppRoutes.riskMap:
        return _materialRoute(settings, const RiskMapScreen());
      case AppRoutes.history:
        return _materialRoute(settings, const ReportsScreen());
      case AppRoutes.offline:
        return _materialRoute(settings, const OfflineScreen());
      case AppRoutes.aiAnalysis:
        return _materialRoute(settings, const AiAnalysisScreen());
      case AppRoutes.settings:
        return _materialRoute(settings, const SettingsScreen());
      case AppRoutes.about:
        return _materialRoute(settings, const AboutScreen());
      case AppRoutes.scannerCamera:
        return _materialRoute(settings, const BarcodeScannerView());
      default:
        return _materialRoute(settings, const HomeScreen());
    }
  }

  static MaterialPageRoute<T> _materialRoute<T>(
    RouteSettings settings,
    Widget page,
  ) {
    return MaterialPageRoute<T>(
      settings: settings,
      builder: (_) => page,
    );
  }
}
