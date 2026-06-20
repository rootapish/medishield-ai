import 'package:medishield_ai/core/models/medicine_record.dart';

/// In-memory mock medicine database.
/// Replace lookup calls with real API calls when backend is ready.
class MedicineDatabase {
  MedicineDatabase._();

  static const Map<String, MedicineRecord> _records = {
    'PCM500123': MedicineRecord(
      batchCode: 'PCM500123',
      medicineName: 'Paracetamol 500mg',
      manufacturer: 'ABC Pharma',
      expiry: '12/2027',
      status: VerificationStatus.verified,
    ),
    'AMOX9876': MedicineRecord(
      batchCode: 'AMOX9876',
      medicineName: 'Amoxicillin 250mg',
      manufacturer: 'XYZ Pharma',
      expiry: '08/2027',
      status: VerificationStatus.verified,
    ),
    'AZI250456': MedicineRecord(
      batchCode: 'AZI250456',
      medicineName: 'Azithromycin 250mg',
      manufacturer: 'MedLife Pharma',
      expiry: '04/2028',
      status: VerificationStatus.verified,
    ),
  };

  /// Looks up a batch code. Returns null for unknown codes.
  /// Lookup is case-insensitive.
  static MedicineRecord? lookup(String batchCode) =>
      _records[batchCode.trim().toUpperCase()] ??
      _records[batchCode.trim()];

  /// Total number of protected medicines in the database.
  static int get totalMedicines => _records.length;
}
