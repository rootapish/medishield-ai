import 'package:flutter/material.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';

class AppLogoPlaceholder extends StatelessWidget {
  const AppLogoPlaceholder({super.key, this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Icon(
        Icons.shield_outlined,
        size: size * 0.55,
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
