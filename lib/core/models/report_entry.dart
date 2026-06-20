import 'dart:convert';

/// A user-submitted counterfeit report stored locally.
class ReportEntry {
  ReportEntry({
    required this.id,
    required this.medicineName,
    required this.batchNumber,
    required this.location,
    required this.submittedAt,
  });

  final String id;
  final String medicineName;
  final String batchNumber;
  final String location;
  final DateTime submittedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'medicineName': medicineName,
        'batchNumber': batchNumber,
        'location': location,
        'submittedAt': submittedAt.toIso8601String(),
      };

  factory ReportEntry.fromJson(Map<String, dynamic> json) => ReportEntry(
        id: json['id'] as String,
        medicineName: json['medicineName'] as String,
        batchNumber: json['batchNumber'] as String,
        location: json['location'] as String,
        submittedAt: DateTime.parse(json['submittedAt'] as String),
      );

  String toJsonString() => jsonEncode(toJson());

  static ReportEntry fromJsonString(String s) =>
      ReportEntry.fromJson(jsonDecode(s) as Map<String, dynamic>);

  /// Pre-seeded sample reports shown before the user submits anything.
  static List<ReportEntry> get seedReports => [
        ReportEntry(
          id: 'seed-1',
          medicineName: 'Crocin 650mg',
          batchNumber: 'CRC-2024-099',
          location: 'Jaipur, Rajasthan',
          submittedAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        ReportEntry(
          id: 'seed-2',
          medicineName: 'Augmentin 625mg',
          batchNumber: 'AUG-2024-211',
          location: 'Delhi, NCR',
          submittedAt: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        ReportEntry(
          id: 'seed-3',
          medicineName: 'Ibuprofen 400mg',
          batchNumber: 'IBU-2024-045',
          location: 'Mumbai, Maharashtra',
          submittedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
}
