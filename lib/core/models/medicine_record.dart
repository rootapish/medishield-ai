/// Verification status for a scanned batch.
enum VerificationStatus { verified, suspicious }

/// A single entry in the local medicine database.
class MedicineRecord {
  const MedicineRecord({
    required this.batchCode,
    required this.medicineName,
    required this.manufacturer,
    required this.expiry,
    required this.status,
  });

  final String batchCode;
  final String medicineName;
  final String manufacturer;
  final String expiry;
  final VerificationStatus status;
}
