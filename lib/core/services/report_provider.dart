import 'package:flutter/foundation.dart';
import 'package:medishield_ai/core/models/report_entry.dart';
import 'package:medishield_ai/core/services/preferences_service.dart';

const String _kReportsKey = 'reports_v1';
const int _kMaxEntries = 100;

/// Persists and exposes user-submitted reports.
/// Backed by SharedPreferences via [PreferencesService].
class ReportProvider extends ChangeNotifier {
  ReportProvider(this._prefs);

  final PreferencesService _prefs;
  final List<ReportEntry> _entries = [];

  List<ReportEntry> get entries => List.unmodifiable(_entries);

  Future<void> initialize() async {
    final raw = await _prefs.getString(_kReportsKey);
    if (raw == null || raw.isEmpty) {
      // First launch — seed with sample reports
      _entries.addAll(ReportEntry.seedReports);
    } else {
      try {
        final lines = raw.split('\n').where((l) => l.isNotEmpty);
        _entries.addAll(lines.map(ReportEntry.fromJsonString));
      } catch (_) {
        _entries.addAll(ReportEntry.seedReports);
      }
    }
    notifyListeners();
  }

  /// Prepends a new report and persists.
  Future<void> addReport(ReportEntry report) async {
    _entries.insert(0, report);
    if (_entries.length > _kMaxEntries) _entries.removeLast();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final joined = _entries.map((e) => e.toJsonString()).join('\n');
    await _prefs.setString(_kReportsKey, joined);
  }
}
