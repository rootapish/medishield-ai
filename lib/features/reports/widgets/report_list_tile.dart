import 'package:flutter/material.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/features/reports/models/report_item.dart';

class ReportListTile extends StatelessWidget {
  const ReportListTile(this.report, {super.key});

  final ReportItem report;

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: ListTile(
        leading: const Icon(Icons.report_gmailerrorred_outlined),
        title: Text(report.medicineName),
        subtitle: Text('Batch: ${report.batchNumber} · ${_formatDate(report.submittedAt)}'),
        trailing: Text(
          report.status,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
