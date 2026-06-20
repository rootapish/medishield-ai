class ScanResult {
  const ScanResult({
    required this.value,
    required this.typeLabel,
  });

  final String value;
  final String typeLabel;

  static const String readyStatus = 'Ready for Verification';
}
