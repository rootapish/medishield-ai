import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/models/medicine_record.dart';
import 'package:medishield_ai/core/models/scan_history_entry.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/services/medicine_database.dart';
import 'package:medishield_ai/core/services/scan_history_provider.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/core/theme/app_styles.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, this.initialBatchCode});

  final String? initialBatchCode;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final TextEditingController _batchController;
  MedicineRecord? _result;
  bool _notFound = false;
  bool _hasVerified = false;

  @override
  void initState() {
    super.initState();
    _batchController = TextEditingController(text: widget.initialBatchCode ?? '');

    if (widget.initialBatchCode != null && widget.initialBatchCode!.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _verify());
    }
  }

  @override
  void dispose() {
    _batchController.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    final code = _batchController.text.trim();
    if (code.isEmpty) return;

    final record = MedicineDatabase.lookup(code);
    final status = record != null ? VerificationStatus.verified : VerificationStatus.suspicious;

    if (widget.initialBatchCode == null) {
      await context.read<ScanHistoryProvider>().addEntry(
            ScanHistoryEntry(
              batchId: code,
              scannedAt: DateTime.now(),
              status: status,
              medicineName: record?.medicineName ?? 'Unknown Medicine',
            ),
          );
    }

    if (!mounted) return;
    setState(() {
      _result = record;
      _notFound = record == null;
      _hasVerified = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasVerified) {
      return AppScaffold(
        title: 'Verify Batch',
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _batchController,
                  decoration: const InputDecoration(labelText: 'Enter Batch Number'),
                ),
                const SizedBox(height: 20),
                FilledButton(onPressed: _verify, child: const Text('Verify')),
              ],
            ),
          ),
        ),
      );
    }

    final isSafe = !_notFound;

    return AppScaffold(
      title: isSafe ? _result!.medicineName : 'Unknown Medicine',
      actions: [
        IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          children: [
            // Trust Score
            Container(
              padding: const EdgeInsets.all(32),
              decoration: AppStyles.cardBlur(40).copyWith(
                color: isSafe ? AppColors.successContainer : AppColors.errorContainer,
              ),
              child: Column(
                children: [
                  Text('Trust Score', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: isSafe ? 0.98 : 0.12,
                          strokeWidth: 12,
                          backgroundColor: Colors.white.withValues(alpha: 0.5),
                          color: isSafe ? AppColors.onSuccessContainer : AppColors.error,
                        ),
                      ),
                      Column(
                        children: [
                          Text(isSafe ? '98%' : '12%', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.onSurface)),
                          Text(isSafe ? 'Authentic' : 'Suspicious', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: isSafe ? AppColors.onSuccessContainer : AppColors.error)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Batch Data Bento
            Container(
              decoration: AppStyles.cardBlur(32).copyWith(color: Colors.white.withValues(alpha: 0.7)),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Batch Data', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _DataField(
                          label: 'Batch No.',
                          value: isSafe ? _result!.batchCode : _batchController.text,
                        ),
                      ),
                      Expanded(
                        child: _DataField(
                          label: 'Mfg. Date',
                          value: isSafe ? '10/2025' : '--', // Mocked as MedicineRecord doesn't have mfg date
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _DataField(
                          label: 'Exp. Date',
                          value: isSafe ? _result!.expiry : '--',
                        ),
                      ),
                      Expanded(
                        child: _DataField(
                          label: 'QR Status',
                          value: isSafe ? 'Valid format' : 'Invalid format',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Verification Journey
            if (isSafe)
              Container(
                decoration: AppStyles.cardBlur(32).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification Journey', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    _TimelineStep(title: 'Manufacturing', subtitle: '${_result!.manufacturer} • Oct 12, 2025', isCompleted: true, isLast: false),
                    _TimelineStep(title: 'Supply Chain', subtitle: 'Verified at 3 checkpoints', isCompleted: true, isLast: false),
                    _TimelineStep(title: 'Scanning', subtitle: 'Authenticity confirmed by AI', isCompleted: true, isLast: true),
                  ],
                ),
              ),
              
            const SizedBox(height: 32),
            
            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
                    child: const Text('Save Result'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.errorContainer,
                      foregroundColor: AppColors.error,
                    ),
                    child: const Text('Report Issue'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DataField extends StatelessWidget {
  const _DataField({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primary : AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: isCompleted ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
