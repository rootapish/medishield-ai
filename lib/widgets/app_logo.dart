import 'package:flutter/material.dart';

/// A composited shield + medical-cross logo built purely from Flutter icons.
///
/// Renders a filled [Icons.shield] as the background and an [Icons.add]
/// (medical cross shape) centred on top of it. Colours are drawn from the
/// active [ColorScheme] by default but can be overridden.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 72,
    this.shieldColor,
    this.crossColor,
  });

  /// Overall bounding size of the logo in logical pixels.
  final double size;

  /// Fill colour of the shield icon. Defaults to [ColorScheme.primary].
  final Color? shieldColor;

  /// Colour of the medical-cross overlay. Defaults to [ColorScheme.onPrimary].
  final Color? crossColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final shield = shieldColor ?? cs.primary;
    final cross = crossColor ?? cs.onPrimary;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Shield base ──────────────────────────────────────
          Icon(
            Icons.shield,
            size: size,
            color: shield,
          ),
          // ── Medical cross overlay ────────────────────────────
          // Shift slightly upward so the cross sits in the shield's
          // visual centre (accounting for the pointed bottom tip).
          Padding(
            padding: EdgeInsets.only(bottom: size * 0.08),
            child: Icon(
              Icons.add,
              size: size * 0.42,
              color: cross,
            ),
          ),
        ],
      ),
    );
  }
}

/// A contained variant used in the Drawer header and Home hero section.
/// Wraps [AppLogo] in a rounded [primaryContainer] tile.
class AppLogoContainer extends StatelessWidget {
  const AppLogoContainer({
    super.key,
    this.size = 72,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final iconSize = size * 0.65;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(size * 0.22),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.20),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.06),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.shield,
            size: iconSize,
            color: cs.onPrimaryContainer,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: iconSize * 0.08),
            child: Icon(
              Icons.add,
              size: iconSize * 0.42,
              color: cs.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
