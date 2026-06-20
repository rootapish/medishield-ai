import 'package:flutter/foundation.dart';
import 'package:medishield_ai/core/models/scan_history_entry.dart';
import 'package:medishield_ai/core/services/preferences_service.dart';

const String _kHistoryKey = 'scan_history_v1';
const int _kMaxEntries = 50;

/// Persists and exposes the scan history list.
/// Backed by SharedPreferences via [PreferencesService].
class ScanHistoryProvider extends ChangeNotifier {
  ScanHistoryProvider(this._prefs);

  final PreferencesService _prefs;
  final List<ScanHistoryEntry> _entries = [];

  List<ScanHistoryEntry> get entries => List.unmodifiable(_entries);

  Future<void> initialize() async {
    final raw = await _prefs.getString(_kHistoryKey);
    if (raw == null || raw.isEmpty) return;

    try {
      // Stored as newline-separated JSON strings
      final lines = raw.split('\n').where((l) => l.isNotEmpty);
      _entries.addAll(lines.map(ScanHistoryEntry.fromJsonString));
      _entries.sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
    } catch (_) {
      // Corrupt data — start fresh
      await _prefs.setString(_kHistoryKey, '');
    }
    notifyListeners();
  }

  /// Prepends a new entry and persists.
  Future<void> addEntry(ScanHistoryEntry entry) async {
    _entries.insert(0, entry);
    if (_entries.length > _kMaxEntries) _entries.removeLast();
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    final joined = _entries.map((e) => e.toJsonString()).join('\n');
    await _prefs.setString(_kHistoryKey, joined);
  }
}
