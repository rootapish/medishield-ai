import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/core/services/app_settings_provider.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    return AppScaffold(
      title: 'About',
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          Center(
            child: Icon(
              Icons.shield_outlined,
              size: 96,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            settings.appName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppConstants.spacingXs),
          Text(
            AppConstants.drawerSubtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Version ${settings.appVersion}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    settings.appTagline,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    'MediShield AI is a modular foundation for future '
                    'AI-powered counterfeit medicine detection, verification, '
                    'and regional threat intelligence.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
