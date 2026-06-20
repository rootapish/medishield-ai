import 'package:flutter/material.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/core/theme/app_styles.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Offline Mode'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Banner
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppStyles.cardBlur(32).copyWith(color: AppColors.surfaceVariant),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off, color: AppColors.onSurfaceVariant, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Offline Mode Active', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text('Scans will be saved locally and synced when online.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Sync Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppStyles.cardBlur(32).copyWith(
                color: AppColors.primaryContainer.withValues(alpha: 0.3),
                border: Border.all(color: AppColors.primaryContainer),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pending Sync', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('12', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.primary)),
                          const SizedBox(width: 8),
                          Text('scans', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primary)),
                        ],
                      ),
                    ],
                  ),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sync),
                    label: const Text('Sync Now'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Scan Action
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(32),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: AppStyles.cardBlur(32).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppStyles.innerGlow(32).copyWith(color: AppColors.surfaceContainer),
                      child: const Icon(Icons.document_scanner, size: 48, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text('Start Offline Scan', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Recent Offline Scans
            Text('Recent Offline Scans', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            const _OfflineScanItem(batch: 'PCM500123', time: '10 mins ago'),
            const SizedBox(height: 12),
            const _OfflineScanItem(batch: 'AMOX9876', time: '2 hours ago'),
          ],
        ),
      ),
    );
  }
}

class _OfflineScanItem extends StatelessWidget {
  const _OfflineScanItem({required this.batch, required this.time});
  final String batch;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppStyles.cardBlur(20).copyWith(color: Colors.white.withValues(alpha: 0.5)),
      child: Row(
        children: [
          const Icon(Icons.qr_code, color: AppColors.outline),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(batch, style: Theme.of(context).textTheme.labelMedium),
                Text('Pending sync', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.error)),
              ],
            ),
          ),
          Text(time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}
