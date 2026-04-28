import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';
import 'application_form_screen.dart';
import 'community_page.dart';
import 'study_bottom_bar.dart';

class ApplicationUniversityMatchesScreen extends StatelessWidget {
  const ApplicationUniversityMatchesScreen({
    super.key,
    this.showBottomBar = true,
    this.onTabSelected,
  });

  final bool showBottomBar;
  final ValueChanged<StudyBottomTab>? onTabSelected;

  static const List<_UniversityMatchData> _matches = [
    _UniversityMatchData(
      name: 'Technical University of Munich',
      country: 'Germany',
      matchPercent: 95,
      program: 'Business Analytics',
      tuition: 'Low tuition / semester fee',
      aid: 'DAAD and excellence scholarships',
      tags: ['Low tuition', 'STEM leader', 'Research', 'Tech pathway'],
      description:
          "TUM is ideal if you're looking for a high-performing technical environment with much stronger cost efficiency than many English-speaking markets.",
      primaryAction: 'Apply to This University',
      topPick: true,
    ),
    _UniversityMatchData(
      name: 'RWTH Aachen University',
      country: 'Germany',
      matchPercent: 88,
      program: 'Business Analytics',
      tuition: 'Low tuition / semester fee',
      aid: 'DAAD and exchange funding',
      tags: ['Engineering power', 'Value', 'Applied', 'Tech pathway'],
      description:
          'RWTH Aachen combines technical strength, affordability, and a serious engineering reputation that is especially attractive for practical students.',
      primaryAction: 'Explore This Option',
    ),
    _UniversityMatchData(
      name: 'University of Freiburg',
      country: 'Germany',
      matchPercent: 82,
      program: 'Business Analytics',
      tuition: 'Moderate tuition / semester contribution',
      aid: 'State and international awards',
      tags: ['Research', 'Student city', 'Balanced', 'Tech pathway'],
      description:
          'Freiburg offers a more intimate environment without sacrificing research quality, making it a strong alternative for balanced-fit applicants.',
      primaryAction: 'Explore This Option',
    ),
  ];

  void _openApplicationForm(BuildContext context, _UniversityMatchData match) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 280),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ApplicationFormScreen(
          universityName: match.name,
          programName: match.program,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          final offset = Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved);
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(position: offset, child: child),
          );
        },
      ),
    );
  }

  void _onBottomTabSelected(BuildContext context, StudyBottomTab tab) {
    if (onTabSelected != null) {
      onTabSelected!(tab);
      return;
    }
    if (tab == StudyBottomTab.application) {
      return;
    }
    if (tab == StudyBottomTab.universities) {
      Navigator.of(context).maybePop();
      return;
    }
    if (tab == StudyBottomTab.community) {
      Navigator.of(context).pushReplacement(
        buildBottomTabRoute(const CommunityPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppPalette.background,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.92, -1.0),
              end: Alignment(1.0, 1.0),
              colors: [
                AppPalette.background,
                AppPalette.surfaceSoft,
                AppPalette.primarySoft,
              ],
              stops: [0.0, 0.68, 1.0],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _ApplicationBackground(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 10,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 226,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              _MatchesHeader(),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 54,
                                child: _SavePrompt(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 184,
                        left: 0,
                        right: 0,
                        child: _MatchSummaryRow(),
                      ),
                      Positioned(
                        top: 238,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: ListView(
                          padding: const EdgeInsets.only(bottom: 118),
                          children: [
                            ..._matches.map(
                              (match) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _UniversityMatchCard(
                                  data: match,
                                  onPrimaryPressed: match.primaryAction
                                          .toLowerCase()
                                          .contains('apply')
                                      ? () => _openApplicationForm(
                                            context,
                                            match,
                                          )
                                      : null,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Center(child: _NewSearchButton()),
                          ],
                        ),
                      ),
                      if (showBottomBar)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 10,
                          child: StudyBottomBar(
                            activeTab: StudyBottomTab.application,
                            onTabSelected: (tab) =>
                                _onBottomTabSelected(context, tab),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ApplicationBackground extends StatelessWidget {
  const _ApplicationBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -56,
            right: -86,
            child: Transform.rotate(
              angle: -0.34,
              child: Container(
                width: 430,
                height: 166,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(220),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppPalette.primary.withValues(alpha: 0.02),
                      AppPalette.primary.withValues(alpha: 0.10),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 24,
            right: -20,
            child: Transform.rotate(
              angle: -0.32,
              child: Container(
                width: 306,
                height: 88,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(220),
                  color: AppPalette.primary.withValues(alpha: 0.06),
                ),
              ),
            ),
          ),
          Positioned(
            top: -72,
            left: -52,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x10000000),
                    Color(0x00FFFFFF),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchSummaryRow extends StatelessWidget {
  const _MatchSummaryRow();

  @override
  Widget build(BuildContext context) {
    const chips = [
      _MatchSummaryChipData(
        icon: Icons.workspace_premium_rounded,
        label: '3 Matches',
      ),
      _MatchSummaryChipData(
        icon: Icons.public_rounded,
        label: 'Germany',
      ),
      _MatchSummaryChipData(
        icon: Icons.business_center_outlined,
        label: 'Business',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 10.0;
        final chipWidth =
            ((constraints.maxWidth - spacing * 2) / 3).clamp(96.0, 156.0);

        return Wrap(
          spacing: spacing,
          runSpacing: 10,
          children: chips
              .map(
                (chip) => SizedBox(
                  width: chipWidth.toDouble(),
                  child: _MatchSummaryChip(data: chip),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _MatchSummaryChip extends StatelessWidget {
  const _MatchSummaryChip({required this.data});

  final _MatchSummaryChipData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.only(left: 8, right: 6),
      decoration: BoxDecoration(
        color: AppPalette.surfaceTint.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPalette.border),
      ),
      child: Row(
        children: [
          Icon(
            data.icon,
            size: 16,
            color: AppPalette.textPrimary,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              data.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppPalette.textPrimary,
                fontSize: 12.2,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchSummaryChipData {
  const _MatchSummaryChipData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class _MatchesHeader extends StatelessWidget {
  const _MatchesHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final titleSize = (width * 0.085).clamp(28.0, 38.0).toDouble();
        final subtitleSize = (width * 0.035).clamp(13.2, 16.0).toDouble();
        final badgeSize = (width * 0.40).clamp(128.0, 168.0).toDouble();

        return SizedBox(
          height: 164,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -8,
                bottom: -6,
                child: _MatchInsightBadge(size: badgeSize),
              ),
              Positioned(
                left: 0,
                top: 10,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width * 0.64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'YOUR PERSONALIZED MATCHES',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppPalette.primary,
                          fontSize: 10.4,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                          letterSpacing: 1.6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Here are your dream universities',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          height: 0.98,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '3 business programs matched to your goals.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppPalette.textSecondary,
                          fontSize: subtitleSize,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MatchInsightBadge extends StatelessWidget {
  const _MatchInsightBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppPalette.surface,
        border: Border.all(color: AppPalette.primaryBorder, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppPalette.shadow.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.68,
            height: size * 0.68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.surfaceTint,
              border: Border.all(color: AppPalette.border),
            ),
          ),
          Container(
            width: size * 0.46,
            height: size * 0.46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPalette.primary,
              boxShadow: [
                BoxShadow(
                  color: AppPalette.shadow.withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.school_rounded,
              color: AppPalette.surface,
              size: size * 0.25,
            ),
          ),
          Positioned(
            top: size * 0.12,
            right: size * 0.14,
            child: Container(
              width: size * 0.22,
              height: size * 0.22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppPalette.surface,
                border: Border.all(color: AppPalette.primaryBorder),
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                color: AppPalette.primary,
                size: size * 0.12,
              ),
            ),
          ),
          Positioned(
            left: size * 0.16,
            right: size * 0.16,
            bottom: size * 0.10,
            child: Container(
              height: size * 0.22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppPalette.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppPalette.border),
                boxShadow: [
                  BoxShadow(
                    color: AppPalette.shadow.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                '95% match',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textPrimary,
                  fontSize: (size * 0.075).clamp(9.5, 12.0).toDouble(),
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavePrompt extends StatelessWidget {
  const _SavePrompt();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppPalette.surface.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: AppPalette.shadow.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(999),
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  color: AppPalette.primary,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Sign in to save',
                  style: TextStyle(
                    color: AppPalette.surface,
                    fontSize: 11.2,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Results ready — sign in only to save',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppPalette.textSoft,
                fontSize: 11.2,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UniversityMatchCard extends StatelessWidget {
  const _UniversityMatchCard({
    required this.data,
    this.onPrimaryPressed,
  });

  final _UniversityMatchData data;
  final VoidCallback? onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 350;
        final horizontalPadding = compact ? 14.0 : 18.0;

        return Container(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            data.topPick ? 14 : 16,
            horizontalPadding,
            16,
          ),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: data.topPick ? AppPalette.primary : AppPalette.border,
              width: data.topPick ? 1.4 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: AppPalette.shadow.withValues(
                  alpha: data.topPick ? 0.10 : 0.06,
                ),
                blurRadius: data.topPick ? 22 : 16,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CardPillRow(topPick: data.topPick),
              SizedBox(height: data.topPick ? 22 : 20),
              Text(
                data.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textStrong,
                  fontSize: compact ? 17.0 : 18.0,
                  fontWeight: FontWeight.w800,
                  height: 1.05,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.country,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textMuted,
                  fontSize: compact ? 12.2 : 12.8,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 18),
              _MatchScoreRow(percent: data.matchPercent),
              const SizedBox(height: 14),
              _InfoBlock(label: 'PROGRAM', value: data.program),
              const SizedBox(height: 8),
              _InfoBlock(label: 'TUITION', value: data.tuition),
              const SizedBox(height: 8),
              _InfoBlock(label: 'SCHOLARSHIP / AID', value: data.aid),
              const SizedBox(height: 14),
              _TagWrap(tags: data.tags),
              const SizedBox(height: 16),
              Container(height: 1, color: AppPalette.divider),
              const SizedBox(height: 15),
              Text(
                data.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textSecondary,
                  fontSize: compact ? 12.3 : 13.0,
                  fontWeight: FontWeight.w500,
                  height: 1.42,
                ),
              ),
              const SizedBox(height: 18),
              _CardActions(
                primaryLabel: data.primaryAction,
                onPrimaryPressed: onPrimaryPressed,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardPillRow extends StatelessWidget {
  const _CardPillRow({required this.topPick});

  final bool topPick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: topPick
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: _TopPickPill(),
                )
              : const SizedBox.shrink(),
        ),
        const _ComparePill(),
      ],
    );
  }
}

class _TopPickPill extends StatelessWidget {
  const _TopPickPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: AppPalette.primary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        'TOP PICK FOR YOU',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: AppPalette.surface,
          fontSize: 9.6,
          fontWeight: FontWeight.w900,
          height: 1.0,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _ComparePill extends StatelessWidget {
  const _ComparePill();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: AppPalette.surfaceTint,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppPalette.border),
          ),
          child: const Text(
            'Compare',
            style: TextStyle(
              color: AppPalette.textSecondary,
              fontSize: 10.4,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchScoreRow extends StatelessWidget {
  const _MatchScoreRow({required this.percent});

  final int percent;

  @override
  Widget build(BuildContext context) {
    final progress = percent / 100.0;

    return Row(
      children: [
        const Text(
          'MATCH',
          style: TextStyle(
            color: AppPalette.textMuted,
            fontSize: 10.4,
            fontWeight: FontWeight.w900,
            height: 1.0,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: AppPalette.border,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppPalette.primary),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$percent%',
          style: const TextStyle(
            color: AppPalette.primary,
            fontSize: 12.2,
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: AppPalette.surfaceSoft,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppPalette.labelMuted,
              fontSize: 9.2,
              fontWeight: FontWeight.w900,
              height: 1.0,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 12.6,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}

class _TagWrap extends StatelessWidget {
  const _TagWrap({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 8,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: AppPalette.primarySoft,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppPalette.primaryBorder),
              ),
              child: Text(
                tag,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.primaryDark,
                  fontSize: 10.4,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CardActions extends StatelessWidget {
  const _CardActions({
    required this.primaryLabel,
    this.onPrimaryPressed,
  });

  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 315;

        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrimaryActionButton(
                label: primaryLabel,
                onTap: onPrimaryPressed,
              ),
              const SizedBox(height: 10),
              const Center(child: _ViewDetailsAction()),
            ],
          );
        }

        return Row(
          children: [
            const Expanded(child: _ViewDetailsAction()),
            const SizedBox(width: 14),
            SizedBox(
              width: constraints.maxWidth * 0.46,
              child: _PrimaryActionButton(
                label: primaryLabel,
                onTap: onPrimaryPressed,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ViewDetailsAction extends StatelessWidget {
  const _ViewDetailsAction();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Text(
            'View Details →',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppPalette.primary,
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({
    required this.label,
    this.onTap,
  });

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: AppPalette.primary.withValues(alpha: 0.22),
                blurRadius: 14,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppPalette.surface,
              fontSize: 12.1,
              fontWeight: FontWeight.w900,
              height: 1.05,
            ),
          ),
        ),
      ),
    );
  }
}

class _NewSearchButton extends StatelessWidget {
  const _NewSearchButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppPalette.border),
          ),
          child: const Text(
            '← Start a New Search',
            style: TextStyle(
              color: AppPalette.textSecondary,
              fontSize: 12.2,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _UniversityMatchData {
  const _UniversityMatchData({
    required this.name,
    required this.country,
    required this.matchPercent,
    required this.program,
    required this.tuition,
    required this.aid,
    required this.tags,
    required this.description,
    required this.primaryAction,
    this.topPick = false,
  });

  final String name;
  final String country;
  final int matchPercent;
  final String program;
  final String tuition;
  final String aid;
  final List<String> tags;
  final String description;
  final String primaryAction;
  final bool topPick;
}
