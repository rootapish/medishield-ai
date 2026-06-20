class ReportItem {
  const ReportItem({
    required this.id,
    required this.medicineName,
    required this.batchNumber,
    required this.submittedAt,
    required this.status,
  });

  final String id;
  final String medicineName;
  final String batchNumber;
  final DateTime submittedAt;
  final String status;

  static final List<ReportItem> mockReports = [
    ReportItem(
      id: '1',
      medicineName: 'Amoxicillin 250mg',
      batchNumber: 'AMX-2024-118',
      submittedAt: DateTime(2024, 11, 12, 14, 30),
      status: 'Under Review',
    ),
    ReportItem(
      id: '2',
      medicineName: 'Ibuprofen 400mg',
      batchNumber: 'IBU-2024-045',
      submittedAt: DateTime(2024, 10, 28, 9, 15),
      status: 'Resolved',
    ),
    ReportItem(
      id: '3',
      medicineName: 'Metformin 500mg',
      batchNumber: 'MET-2024-302',
      submittedAt: DateTime(2024, 10, 5, 16, 45),
      status: 'Submitted',
    ),
  ];
}
