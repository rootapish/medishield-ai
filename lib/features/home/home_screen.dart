import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/services/scan_history_provider.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/core/theme/app_styles.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'PharmaTrust',
      appBarTransparent: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 120), // Padding for transparent appbar and floating navbar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _GreetingSection(),
            SizedBox(height: 32),
            _BentoGrid(),
            SizedBox(height: 32),
            _RecentScansSection(),
            SizedBox(height: 32),
            _QuickActionsSection(),
            SizedBox(height: 32),
            _SystemOverviewSection(),
          ],
        ),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  const _GreetingSection();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good morning,', style: tt.headlineLarge?.copyWith(color: AppColors.onSurface)),
            Text('Ananya 🌿', style: tt.displayLarge?.copyWith(color: AppColors.primary)),
            const SizedBox(height: 12),
            Text('Let\'s keep medicines safe together.', style: tt.bodyMedium?.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
        Icon(Icons.eco_outlined, size: 64, color: AppColors.primaryContainer), // Placeholder for 3D illustration
      ],
    );
  }
}

class _BentoGrid extends StatelessWidget {
  const _BentoGrid();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Scan CTA
        InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.scan),
          borderRadius: BorderRadius.circular(40),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: AppStyles.cardBlur(40).copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: AppStyles.innerGlow(40).copyWith(
                    color: AppColors.primaryContainer.withValues(alpha: 0.4),
                  ),
                  child: const Icon(Icons.document_scanner_outlined, size: 40, color: AppColors.primary),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Scan Medicine', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 8),
                      Text('Check authenticity and verify pharmaceutical standards in seconds.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Get Started', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.primary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 16, color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Stats Overview
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Scans', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text('128', style: Theme.of(context).textTheme.displayLarge?.copyWith(color: AppColors.primary)),
                        const SizedBox(width: 8),
                        Text('+12 today', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verified', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('96', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: const Color(0xFF4caf50))),
                        const SizedBox(width: 4),
                        const Icon(Icons.verified, size: 18, color: Color(0xFF4caf50)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white.withValues(alpha: 0.7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Suspicious', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('8', style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.error)),
                        const SizedBox(width: 4),
                        const Icon(Icons.warning, size: 18, color: AppColors.error),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // High Risk Alert Banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppStyles.cardBlur(40).copyWith(
            color: AppColors.secondaryContainer.withValues(alpha: 0.4),
            border: Border.all(color: AppColors.secondaryContainer),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: AppStyles.cardBlur(24).copyWith(color: Colors.white),
                child: const Icon(Icons.report_problem_outlined, color: AppColors.error),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('High Risk Alert', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.onSurface)),
                    Text('Counterfeit medicine activity in your area is increasing.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentScansSection extends StatelessWidget {
  const _RecentScansSection();

  @override
  Widget build(BuildContext context) {
    final history = context.watch<ScanHistoryProvider>().entries.take(3).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Scans', style: Theme.of(context).textTheme.headlineSmall),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (history.isEmpty)
           const Center(child: Text('No scans yet'))
        else
          ...history.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _ScanItem(
              name: e.medicineName,
              status: e.status.name.toUpperCase(),
              isVerified: e.status.name == 'verified',
            ),
          )),
      ],
    );
  }
}

class _ScanItem extends StatelessWidget {
  const _ScanItem({required this.name, required this.status, required this.isVerified});
  final String name;
  final String status;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppStyles.cardBlur(40).copyWith(
        color: Colors.white.withValues(alpha: 0.5),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: AppStyles.innerGlow(24).copyWith(color: AppColors.surfaceContainer),
            child: Icon(Icons.medication_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.labelMedium),
                Text('Just now', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isVerified ? const Color(0xFFe8f5e9) : const Color(0xFFffebee),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isVerified ? const Color(0xFF2e7d32) : AppColors.error,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: AppColors.outline),
        ],
      ),
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _ActionBtn(icon: Icons.description_outlined, label: 'My Reports', onTap: () => Navigator.pushNamed(context, AppRoutes.history))),
            const SizedBox(width: 16),
            Expanded(child: _ActionBtn(icon: Icons.location_on_outlined, label: 'Risk Map', onTap: () => Navigator.pushNamed(context, AppRoutes.riskMap))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _ActionBtn(icon: Icons.cloud_off_outlined, label: 'Offline Mode', onTap: () => Navigator.pushNamed(context, AppRoutes.offline))),
            const SizedBox(width: 16),
            Expanded(child: _ActionBtn(icon: Icons.help_outline, label: 'Support', onTap: () {})),
          ],
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: AppStyles.cardBlur(40).copyWith(color: Colors.white.withValues(alpha: 0.5)),
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(label, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _SystemOverviewSection extends StatelessWidget {
  const _SystemOverviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppStyles.cardBlur(40).copyWith(
        border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text('System Overview', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Gauge(label: 'SAFETY', value: 92),
              _Gauge(label: 'UPTIME', value: 96),
              _Gauge(label: 'TRUST', value: 84),
            ],
          )
        ],
      ),
    );
  }
}

class _Gauge extends StatelessWidget {
  const _Gauge({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: CircularProgressIndicator(
                value: value / 100,
                strokeWidth: 5,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                color: AppColors.primary,
              ),
            ),
            Text('$value%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.onSurfaceVariant)),
      ],
    );
  }
}
