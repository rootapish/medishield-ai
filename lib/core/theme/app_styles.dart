import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();

  static BoxDecoration neumorphicRaised(double radius) => BoxDecoration(
        color: const Color(0xFFfef7ff),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33DAC1C1), // rgba(218, 193, 193, 0.2)
            offset: Offset(8, 8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color(0xE6FFFFFF), // rgba(255, 255, 255, 0.9)
            offset: Offset(-8, -8),
            blurRadius: 16,
          ),
        ],
      );

  static BoxDecoration neumorphicSunken(double radius) => BoxDecoration(
        color: const Color(0xFFfef7ff),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33DAC1C1), // inset 4px 4px 8px
            offset: Offset(4, 4),
            blurRadius: 8,
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            color: Color(0xCCFFFFFF), // inset -4px -4px 8px
            offset: Offset(-4, -4),
            blurRadius: 8,
            blurStyle: BlurStyle.inner,
          ),
        ],
      );

  static BoxDecoration cardBlur(double radius) => BoxDecoration(
        color: const Color(0xB3FFFFFF), // rgba(255,255,255,0.7)
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1463597A), // rgba(99, 89, 122, 0.08)
            offset: Offset(0, 10),
            blurRadius: 30,
          ),
        ],
      );

  static BoxDecoration innerGlow(double radius) => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0xCCFFFFFF), // inset 0 2px 4px rgba(255, 255, 255, 0.8)
            offset: Offset(0, 2),
            blurRadius: 4,
            blurStyle: BlurStyle.inner,
          ),
        ],
      );
}
