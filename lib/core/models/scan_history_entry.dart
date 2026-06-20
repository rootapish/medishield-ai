import 'dart:convert';
import 'package:medishield_ai/core/models/medicine_record.dart';

/// A single scan history entry stored locally.
class ScanHistoryEntry {
  ScanHistoryEntry({
    required this.batchId,
    required this.scannedAt,
    required this.status,
    required this.medicineName,
  });

  final String batchId;
  final DateTime scannedAt;
  final VerificationStatus status;
  final String medicineName;

  Map<String, dynamic> toJson() => {
        'batchId': batchId,
        'scannedAt': scannedAt.toIso8601String(),
        'status': status.name,
        'medicineName': medicineName,
      };

  factory ScanHistoryEntry.fromJson(Map<String, dynamic> json) =>
      ScanHistoryEntry(
        batchId: json['batchId'] as String,
        scannedAt: DateTime.parse(json['scannedAt'] as String),
        status: VerificationStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => VerificationStatus.suspicious,
        ),
        medicineName: json['medicineName'] as String,
      );

  String toJsonString() => jsonEncode(toJson());

  static ScanHistoryEntry fromJsonString(String s) =>
      ScanHistoryEntry.fromJson(jsonDecode(s) as Map<String, dynamic>);
}
