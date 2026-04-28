import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';
import 'community_page.dart';
import 'study_bottom_bar.dart';

class ApplicationUniversityMatchesScreen extends StatelessWidget {
  const ApplicationUniversityMatchesScreen({super.key});

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

  void _onBottomTabSelected(BuildContext context, StudyBottomTab tab) {
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.only(top: 18, bottom: 118),
                  children: [
                    const _MatchesHeader(),
                    const SizedBox(height: 18),
                    ..._matches.map(
                      (match) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _UniversityMatchCard(data: match),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(child: _NewSearchButton()),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: StudyBottomBar(
                    activeTab: StudyBottomTab.application,
                    onTabSelected: (tab) => _onBottomTabSelected(context, tab),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MatchesHeader extends StatelessWidget {
  const _MatchesHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final titleSize = (width * 0.083).clamp(28.0, 38.0).toDouble();
        final subtitleSize = (width * 0.035).clamp(13.4, 16.0).toDouble();
        final foxSize = (width * 0.26).clamp(82.0, 112.0).toDouble();

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -6,
              bottom: 14,
              child: _AiAvatar(size: foxSize),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * 0.72),
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
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppPalette.textPrimary,
                      fontSize: titleSize,
                      fontWeight: FontWeight.w800,
                      height: 0.98,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Based on your profile, I found 3 programs in business that align beautifully with your goals, budget, and strengths.',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppPalette.textSecondary,
                      fontSize: subtitleSize,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const _SavePrompt(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AiAvatar extends StatelessWidget {
  const _AiAvatar({required this.size});

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
      child: Image.asset(
        'assets/icon/fox_search_header.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _SavePrompt extends StatelessWidget {
  const _SavePrompt();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
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
              child: const Text(
                'Sign in to save',
                style: TextStyle(
                  color: AppPalette.surface,
                  fontSize: 12.2,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
        const Text(
          'Your results are available now — sign in only to save',
          style: TextStyle(
            color: AppPalette.textSoft,
            fontSize: 11.2,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class _UniversityMatchCard extends StatelessWidget {
  const _UniversityMatchCard({required this.data});

  final _UniversityMatchData data;

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
              _CardActions(primaryLabel: data.primaryAction),
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
  const _CardActions({required this.primaryLabel});

  final String primaryLabel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 315;

        if (narrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _PrimaryActionButton(label: primaryLabel),
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
              child: _PrimaryActionButton(label: primaryLabel),
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
  const _PrimaryActionButton({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
