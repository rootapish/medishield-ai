import 'package:flutter/material.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/widgets/app_nav_bar.dart';

const _shellRoutes = {
  AppRoutes.home,
  AppRoutes.scan,
  AppRoutes.riskMap,
  AppRoutes.history,
};

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.appBarTransparent = false,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool appBarTransparent;

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isShellRoute = _shellRoutes.contains(currentRoute);

    final defaultActions = [
      IconButton(
        icon: const Icon(Icons.notifications_outlined),
        tooltip: 'Notifications',
        onPressed: () {},
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: appBarTransparent,
      appBar: AppBar(
        backgroundColor: appBarTransparent ? Colors.transparent : AppColors.background.withValues(alpha: 0.8),
        flexibleSpace: appBarTransparent ? null : ClipRect(
          child: BackdropFilter(
            filter: AppColors.background.withValues(alpha: 0.8) == Colors.transparent ? null : 
              const ColorFilter.mode(Colors.transparent, BlendMode.srcOver), // Just to support blur later if needed
            child: Container(color: Colors.transparent),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryContainer,
                border: Border.all(color: AppColors.primaryContainer),
              ),
              child: const Icon(Icons.person, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: actions ?? defaultActions,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: body,
          ),
          if (isShellRoute)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: AppNavBar(currentRoute: currentRoute),
              ),
            ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
