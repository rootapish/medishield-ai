import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';

class _Dest {
  const _Dest({
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
  final String route;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

const List<_Dest> _kDests = [
  _Dest(
    route: AppRoutes.home,
    icon: Icons.home_outlined,
    selectedIcon: Icons.home,
    label: 'Home',
  ),
  _Dest(
    route: AppRoutes.scan,
    icon: Icons.document_scanner_outlined,
    selectedIcon: Icons.document_scanner,
    label: 'Scan',
  ),
  _Dest(
    route: AppRoutes.riskMap,
    icon: Icons.map_outlined,
    selectedIcon: Icons.map,
    label: 'Map',
  ),
  _Dest(
    route: AppRoutes.history,
    icon: Icons.history_outlined,
    selectedIcon: Icons.history,
    label: 'History',
  ),
];

int navIndexForRoute(String? route) =>
    _kDests.indexWhere((d) => d.route == route);

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    super.key,
    required this.currentRoute,
  });

  final String? currentRoute;

  @override
  Widget build(BuildContext context) {
    final idx = navIndexForRoute(currentRoute);
    final selectedIndex = idx < 0 ? 0 : idx;

    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF63597A).withValues(alpha: 0.08),
            offset: const Offset(0, 10),
            blurRadius: 30,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_kDests.length, (i) {
                final d = _kDests[i];
                final isSelected = i == selectedIndex;

                return InkWell(
                  onTap: () {
                    if (d.route == currentRoute) return;
                    Navigator.pushReplacementNamed(context, d.route);
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(24),
                          )
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? d.selectedIcon : d.icon,
                          color: isSelected ? AppColors.primary : AppColors.outline,
                          size: 24,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          d.label,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: isSelected ? AppColors.primary : AppColors.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
