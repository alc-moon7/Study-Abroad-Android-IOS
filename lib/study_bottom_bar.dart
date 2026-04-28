import 'package:flutter/material.dart';

import 'app_theme.dart';

enum StudyBottomTab {
  home,
  universities,
  application,
  community,
  profile,
}

Route<void> buildBottomTabRoute(Widget child) {
  return PageRouteBuilder<void>(
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      final offset = Tween<Offset>(
        begin: const Offset(0, 0.06),
        end: Offset.zero,
      ).animate(curved);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: offset,
          child: child,
        ),
      );
    },
  );
}

class StudyBottomBar extends StatelessWidget {
  const StudyBottomBar({
    super.key,
    required this.activeTab,
    required this.onTabSelected,
  });

  final StudyBottomTab activeTab;
  final ValueChanged<StudyBottomTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: AppPalette.shadow.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _StudyBottomBarItem(
              icon: Icons.home_outlined,
              label: 'Home',
              active: activeTab == StudyBottomTab.home,
              onTap: () => onTabSelected(StudyBottomTab.home),
            ),
          ),
          Expanded(
            child: _StudyBottomBarItem(
              icon: Icons.school_rounded,
              label: 'Universities',
              active: activeTab == StudyBottomTab.universities,
              onTap: () => onTabSelected(StudyBottomTab.universities),
            ),
          ),
          Expanded(
            child: _StudyBottomBarItem(
              icon: Icons.assignment_rounded,
              label: 'Application',
              badgeText: '3',
              active: activeTab == StudyBottomTab.application,
              onTap: () => onTabSelected(StudyBottomTab.application),
            ),
          ),
          Expanded(
            child: _StudyBottomBarItem(
              icon: Icons.groups_rounded,
              label: 'Community',
              active: activeTab == StudyBottomTab.community,
              onTap: () => onTabSelected(StudyBottomTab.community),
            ),
          ),
          Expanded(
            child: _StudyBottomBarItem(
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              active: activeTab == StudyBottomTab.profile,
              onTap: () => onTabSelected(StudyBottomTab.profile),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyBottomBarItem extends StatelessWidget {
  const _StudyBottomBarItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
    this.badgeText,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final iconColor = active ? AppPalette.primary : AppPalette.textMuted;
    final textColor = active ? AppPalette.primaryDark : AppPalette.textMuted;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  ),
                  if (badgeText != null)
                    Positioned(
                      right: -7,
                      top: -5,
                      child: Container(
                        width: 19,
                        height: 19,
                        decoration: BoxDecoration(
                          color: AppPalette.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppPalette.surface,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            badgeText!,
                            style: const TextStyle(
                              color: AppPalette.surface,
                              fontSize: 9.2,
                              fontWeight: FontWeight.w700,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 10.2,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
