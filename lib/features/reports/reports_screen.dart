import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/core/models/report_entry.dart';
import 'package:medishield_ai/core/services/report_provider.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';
import 'package:medishield_ai/widgets/section_header.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _medicineController = TextEditingController();
  final _batchController = TextEditingController();
  final _locationController = TextEditingController();
  bool _photoSelected = false;

  @override
  void dispose() {
    _medicineController.dispose();
    _batchController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    final report = ReportEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      medicineName: _medicineController.text.trim(),
      batchNumber: _batchController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? 'Location not specified'
          : _locationController.text.trim(),
      submittedAt: DateTime.now(),
    );

    await context.read<ReportProvider>().addReport(report);

    if (!mounted) return;

    _medicineController.clear();
    _batchController.clear();
    _locationController.clear();
    setState(() => _photoSelected = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 8),
            Text('Report submitted successfully.'),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportProvider>().entries;
    final cs = Theme.of(context).colorScheme;

    return AppScaffold(
      title: 'Reports',
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // ── Form Card ────────────────────────────────────────────────
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.report_outlined, color: cs.primary),
                        const SizedBox(width: AppConstants.spacingSm),
                        Text(
                          'Submit Suspicious Medicine Report',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingMd),

                    // Medicine name
                    TextFormField(
                      controller: _medicineController,
                      decoration: const InputDecoration(
                        labelText: 'Medicine Name *',
                        hintText: 'e.g. Paracetamol 500mg',
                        prefixIcon: Icon(Icons.medication_outlined),
                      ),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Please enter a medicine name'
                              : null,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),

                    // Batch number
                    TextFormField(
                      controller: _batchController,
                      decoration: const InputDecoration(
                        labelText: 'Batch Number *',
                        hintText: 'e.g. PCM-2024-099',
                        prefixIcon: Icon(Icons.qr_code_2_outlined),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      validator: (v) =>
                          v == null || v.trim().isEmpty
                              ? 'Please enter a batch number'
                              : null,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),

                    // Location
                    TextFormField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        hintText: 'City, State (optional)',
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),
                      textCapitalization: TextCapitalization.words,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),

                    // Photo upload placeholder
                    GestureDetector(
                      onTap: () =>
                          setState(() => _photoSelected = !_photoSelected),
                      child: Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _photoSelected
                              ? cs.primaryContainer.withValues(alpha: 0.4)
                              : cs.surfaceContainerHighest
                                  .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius),
                          border: Border.all(
                            color: _photoSelected
                                ? cs.primary.withValues(alpha: 0.5)
                                : cs.outlineVariant,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _photoSelected
                                  ? Icons.image_outlined
                                  : Icons.add_photo_alternate_outlined,
                              size: 32,
                              color: _photoSelected
                                  ? cs.primary
                                  : cs.onSurfaceVariant,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _photoSelected
                                  ? 'Photo attached'
                                  : 'Tap to upload photo evidence',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: _photoSelected
                                        ? cs.primary
                                        : cs.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),

                    // Submit button
                    FilledButton.icon(
                      onPressed: _submitReport,
                      icon: const Icon(Icons.send_outlined),
                      label: const Text('Submit Report'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // ── Recent Reports ───────────────────────────────────────────
          SectionHeader(
            title: 'Recent Reports',
            subtitle: '${reports.length} report(s)',
          ),
          const SizedBox(height: AppConstants.spacingSm),
          ...reports.map((r) => _ReportTile(report: r)),
        ],
      ),
    );
  }
}

// ── Report tile ───────────────────────────────────────────────────────────────

class _ReportTile extends StatelessWidget {
  const _ReportTile({required this.report});
  final ReportEntry report;

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} hr ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingXs),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.errorContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.report_outlined, color: cs.error, size: 22),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.medicineName,
                    style: tt.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${report.batchNumber} · ${report.location}',
                    style:
                        tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              _timeAgo(report.submittedAt),
              style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
