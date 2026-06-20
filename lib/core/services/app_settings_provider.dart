import 'package:flutter/foundation.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/core/services/preferences_service.dart';

class AppSettingsProvider extends ChangeNotifier {
  AppSettingsProvider(this._preferencesService);

  final PreferencesService _preferencesService;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  String get appName => AppConstants.appName;
  String get appVersion => AppConstants.appVersion;
  String get appTagline => AppConstants.appTagline;

  Future<void> initialize() async {
    await _preferencesService.initialize();
    _isInitialized = true;
    notifyListeners();
  }
}
