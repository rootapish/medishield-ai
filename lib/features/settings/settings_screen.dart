import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/core/services/app_settings_provider.dart';
import 'package:medishield_ai/core/theme/theme_provider.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showAboutDialog(BuildContext context) {
    final settings = context.read<AppSettingsProvider>();

    showAboutDialog(
      context: context,
      applicationName: settings.appName,
      applicationVersion: settings.appVersion,
      applicationIcon: const Icon(Icons.shield_outlined, size: 48),
      children: [
        Text(settings.appTagline),
        const SizedBox(height: AppConstants.spacingSm),
        const Text(
          'MediShield AI is a foundation app for future AI-powered '
          'counterfeit medicine detection features.',
        ),
      ],
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text(
          'Privacy policy content will be added before public release. '
          'This placeholder confirms the settings module is ready for '
          'future legal and compliance content.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return AppScaffold(
      title: 'Settings',
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacingMd,
              AppConstants.spacingMd,
              AppConstants.spacingMd,
              AppConstants.spacingXs,
            ),
            child: Text(
              'Theme Selection',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
            ),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('Light'),
                  icon: Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('Dark'),
                  icon: Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('System'),
                  icon: Icon(Icons.settings_brightness_outlined),
                ),
              ],
              selected: {themeProvider.themeMode},
              onSelectionChanged: (selection) {
                themeProvider.setThemeMode(selection.first);
              },
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.new_releases_outlined),
            title: const Text('App Version'),
            subtitle: Text(settings.appVersion),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy Policy'),
            onTap: () => _showPrivacyPolicyDialog(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About App'),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }
}
