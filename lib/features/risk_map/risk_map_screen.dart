import 'package:flutter/material.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/core/theme/app_styles.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

const List<_AlertData> _alerts = [
  _AlertData(
    title: 'Counterfeit Paracetamol Batch',
    location: 'Jaipur, Rajasthan',
    level: 'High Risk',
    time: '2 hours ago',
    isHighRisk: true,
  ),
  _AlertData(
    title: 'Suspicious Amoxicillin packaging',
    location: 'Delhi NCR',
    level: 'Medium Risk',
    time: '5 hours ago',
    isHighRisk: false,
  ),
  _AlertData(
    title: 'Unregistered Vendor reported',
    location: 'Kanpur, UP',
    level: 'Medium Risk',
    time: '1 day ago',
    isHighRisk: false,
  ),
];

class _AlertData {
  const _AlertData({
    required this.title,
    required this.location,
    required this.level,
    required this.time,
    required this.isHighRisk,
  });

  final String title;
  final String location;
  final String level;
  final String time;
  final bool isHighRisk;
}

class RiskMapScreen extends StatelessWidget {
  const RiskMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Global Risk Map',
      appBarTransparent: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 100, 20, 120),
        child: Column(
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('All Regions', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary)),
                        const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Last 7 Days', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary)),
                        const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Map Placeholder
            Container(
              height: 240,
              width: double.infinity,
              decoration: AppStyles.innerGlow(32).copyWith(color: const Color(0xFFe9e6ec)),
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.public, size: 160, color: Colors.black12),
                  Positioned(
                    top: 80,
                    left: 100,
                    child: _MapPin(isHigh: true),
                  ),
                  Positioned(
                    top: 120,
                    left: 180,
                    child: _MapPin(isHigh: false),
                  ),
                  Positioned(
                    top: 160,
                    left: 80,
                    child: _MapPin(isHigh: false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Active Alerts List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Active Alerts', style: Theme.of(context).textTheme.titleLarge),
                TextButton(onPressed: () {}, child: const Text('Filter')),
              ],
            ),
            const SizedBox(height: 16),
            ..._alerts.map((alert) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _AlertCard(alert: alert),
            )),

            const SizedBox(height: 16),

            // Risk Trends Bar Chart Mock
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppStyles.cardBlur(32).copyWith(color: Colors.white.withValues(alpha: 0.7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Risk Trends', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Bar(height: 40, label: 'Mon'),
                      _Bar(height: 60, label: 'Tue'),
                      _Bar(height: 30, label: 'Wed'),
                      _Bar(height: 90, label: 'Thu', isHigh: true),
                      _Bar(height: 50, label: 'Fri'),
                      _Bar(height: 40, label: 'Sat'),
                      _Bar(height: 20, label: 'Sun'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.isHigh});
  final bool isHigh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: isHigh ? AppColors.error : AppColors.primaryContainer,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: (isHigh ? AppColors.error : AppColors.primaryContainer).withValues(alpha: 0.4),
            blurRadius: 8,
            spreadRadius: 4,
          )
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});
  final _AlertData alert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: alert.isHighRisk ? AppColors.errorContainer : AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              alert.isHighRisk ? Icons.warning : Icons.info_outline,
              color: alert.isHighRisk ? AppColors.error : AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.title, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(alert.location, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(alert.level, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: alert.isHighRisk ? AppColors.error : AppColors.primary)),
              const SizedBox(height: 4),
              Text(alert.time, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.height, required this.label, this.isHigh = false});
  final double height;
  final String label;
  final bool isHigh;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: isHigh ? AppColors.error : AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}
