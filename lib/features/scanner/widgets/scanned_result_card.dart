import 'package:flutter/material.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/features/scanner/models/scan_result.dart';
import 'package:medishield_ai/widgets/section_header.dart';

class ScannedResultCard extends StatelessWidget {
  const ScannedResultCard({
    super.key,
    required this.result,
    required this.onVerifyBatch,
  });

  final ScanResult result;
  final VoidCallback onVerifyBatch;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Scanned Result'),
            const SizedBox(height: AppConstants.spacingMd),
            InfoRow(label: 'Value', value: result.value),
            InfoRow(label: 'Type', value: result.typeLabel),
            InfoRow(
              label: 'Status',
              value: ScanResult.readyStatus,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            FilledButton(
              onPressed: onVerifyBatch,
              child: const Text('Verify Batch'),
            ),
          ],
        ),
      ),
    );
  }
}
