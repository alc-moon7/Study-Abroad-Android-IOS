import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';
import 'application_university_matches_screen.dart';
import 'community_page.dart';
import 'study_bottom_bar.dart';

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _shortlistedIds = <String>{};
  final PageController _pageController = PageController();
  StudyBottomTab _activeTab = StudyBottomTab.universities;

  static const List<_UniversityData> _universities = [
    _UniversityData(
      id: 'harvard',
      name: 'Harvard University',
      countryFlag: '\u{1F1FA}\u{1F1F8}',
      location: 'Cambridge, USA',
      rating: '4.8',
      reviews: '1,250 reviews',
      ranking: '#4 QS World Ranking',
      tuitionFee: '\$54,000',
      intake: 'Sep, Jan, May',
      logoKind: _UniversityLogoKind.harvard,
    ),
    _UniversityData(
      id: 'mit',
      name: 'MIT',
      countryFlag: '\u{1F1FA}\u{1F1F8}',
      location: 'Cambridge, USA',
      rating: '4.7',
      reviews: '980 reviews',
      ranking: '#1 QS World Ranking',
      tuitionFee: '\$55,878',
      intake: 'Sep, Feb',
      logoKind: _UniversityLogoKind.mit,
    ),
    _UniversityData(
      id: 'oxford',
      name: 'University of Oxford',
      countryFlag: '\u{1F1EC}\u{1F1E7}',
      location: 'Oxford, United Kingdom',
      rating: '4.6',
      reviews: '870 reviews',
      ranking: '#3 QS World Ranking',
      tuitionFee: '\u00A328,980',
      intake: 'Oct, Jan, Apr',
      logoKind: _UniversityLogoKind.oxford,
    ),
    _UniversityData(
      id: 'nus',
      name: 'National University of Singapore',
      countryFlag: '\u{1F1F8}\u{1F1EC}',
      location: 'Singapore',
      rating: '4.5',
      reviews: '760 reviews',
      ranking: '#8 QS World Ranking',
      tuitionFee: '\$17,550',
      intake: 'Aug, Jan',
      logoKind: _UniversityLogoKind.nus,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleShortlist(String id) {
    setState(() {
      if (_shortlistedIds.contains(id)) {
        _shortlistedIds.remove(id);
      } else {
        _shortlistedIds.add(id);
      }
    });
  }

  void _onBottomTabSelected(StudyBottomTab tab) {
    final pageIndex = _pageIndexForTab(tab);
    if (pageIndex == null || tab == _activeTab) {
      return;
    }

    setState(() {
      _activeTab = tab;
    });

    if (!_pageController.hasClients) {
      return;
    }

    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  int? _pageIndexForTab(StudyBottomTab tab) {
    return switch (tab) {
      StudyBottomTab.universities => 0,
      StudyBottomTab.application => 1,
      StudyBottomTab.community => 2,
      StudyBottomTab.home || StudyBottomTab.profile => null,
    };
  }

  StudyBottomTab _tabForPageIndex(int index) {
    return switch (index) {
      1 => StudyBottomTab.application,
      2 => StudyBottomTab.community,
      _ => StudyBottomTab.universities,
    };
  }

  void _handlePageChanged(int index) {
    final tab = _tabForPageIndex(index);
    if (tab == _activeTab) {
      return;
    }
    setState(() {
      _activeTab = tab;
    });
  }

  void _goToUniversitiesTab() {
    _onBottomTabSelected(StudyBottomTab.universities);
  }

  Widget _buildFixedBottomBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
          child: StudyBottomBar(
            activeTab: _activeTab,
            onTabSelected: _onBottomTabSelected,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabPages() {
    return [
      _UniversityListTabContent(
        searchController: _searchController,
        universities: _universities,
        shortlistedIds: _shortlistedIds,
        onShortlistToggle: _toggleShortlist,
      ),
      ApplicationUniversityMatchesScreen(
        showBottomBar: false,
        onTabSelected: _onBottomTabSelected,
      ),
      CommunityPage(
        showBottomBar: false,
        onTabSelected: _onBottomTabSelected,
        onBack: _goToUniversitiesTab,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppPalette.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _handlePageChanged,
                children: _buildTabPages(),
              ),
            ),
            _buildFixedBottomBar(),
          ],
        ),
      ),
    );
  }
}

class _UniversityListTabContent extends StatelessWidget {
  const _UniversityListTabContent({
    required this.searchController,
    required this.universities,
    required this.shortlistedIds,
    required this.onShortlistToggle,
  });

  final TextEditingController searchController;
  final List<_UniversityData> universities;
  final Set<String> shortlistedIds;
  final ValueChanged<String> onShortlistToggle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
          const _UniversityBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 212,
                      child: Stack(
                        children: [
                          const _HeroSection(),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 60,
                            child: _SearchField(
                              controller: searchController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 170,
                    left: 0,
                    right: 0,
                    child: _FilterRow(),
                  ),
                  Positioned(
                    top: 224,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ListView(
                      padding: const EdgeInsets.only(bottom: 104),
                      children: [
                        ...universities.map(
                          (university) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _UniversityCard(
                              data: university,
                              shortlisted:
                                  shortlistedIds.contains(university.id),
                              onShortlistTap: () =>
                                  onShortlistToggle(university.id),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const _AdviceCard(),
                      ],
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

class _UniversityBackground extends StatelessWidget {
  const _UniversityBackground();

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

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final titleSize = (width * 0.085).clamp(28.0, 38.0).toDouble();
        final subtitleSize = (width * 0.035).clamp(14.0, 18.0).toDouble();

        return SizedBox(
          height: 164,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -8,
                bottom: -30,
                child: Image.asset(
                  'assets/icon/fox_search_header.png',
                  width: (width * 0.43).clamp(138.0, 178.0).toDouble(),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                left: 0,
                top: 10,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width * 0.60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Universities',
                        style: TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          height: 0.95,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '500+ trusted universities worldwide',
                        style: TextStyle(
                          color: AppPalette.textSecondary,
                          fontSize: subtitleSize,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
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

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppPalette.surface.withValues(alpha: 0.98),
        borderRadius: BorderRadius.circular(18),
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
          const Center(
            child: Icon(
              Icons.search_rounded,
              color: AppPalette.textPrimary,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: TextField(
                  controller: controller,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: AppPalette.primary,
                  style: const TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 13.6,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: 'Search university, course or country...',
                    hintStyle: TextStyle(
                      color: AppPalette.textMuted,
                      fontSize: 13.6,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow();

  @override
  Widget build(BuildContext context) {
    const filters = [
      _FilterData(
        icon: Icons.language_rounded,
        label: 'Country',
        trailingIcon: Icons.keyboard_arrow_down_rounded,
      ),
      _FilterData(
        icon: Icons.military_tech_outlined,
        label: 'QS Ranking',
        trailingIcon: Icons.keyboard_arrow_down_rounded,
      ),
      _FilterData(
        icon: Icons.menu_book_outlined,
        label: 'Programs',
        trailingIcon: Icons.keyboard_arrow_down_rounded,
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
          children: filters
              .map(
                (filter) => SizedBox(
                  width: chipWidth.toDouble(),
                  child: _FilterChip(data: filter),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.data});

  final _FilterData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.only(left: 8, right: 6),
      decoration: BoxDecoration(
        color: AppPalette.surfaceTint.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppPalette.border,
        ),
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
              textAlign: TextAlign.left,
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
          if (data.trailingIcon != null) ...[
            const SizedBox(width: 0.5),
            Icon(
              data.trailingIcon,
              size: 16,
              color: AppPalette.textPrimary,
            ),
          ],
        ],
      ),
    );
  }
}

class _UniversityCard extends StatelessWidget {
  const _UniversityCard({
    required this.data,
    required this.shortlisted,
    required this.onShortlistTap,
  });

  final _UniversityData data;
  final bool shortlisted;
  final VoidCallback onShortlistTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(9, 5, 9, 5),
      decoration: BoxDecoration(
        color: AppPalette.surface.withValues(alpha: 0.985),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppPalette.shadow.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 350;
          final logoWidth =
              (constraints.maxWidth * 0.21).clamp(72.0, 82.0).toDouble();
          final statsWidth =
              (constraints.maxWidth * 0.275).clamp(92.0, 108.0).toDouble();
          final availableInfoWidth =
              constraints.maxWidth - logoWidth - statsWidth - 27;
          final titleSize = data.name.length > 26
              ? (compact ? 13.2 : 13.8)
              : (compact ? 14.4 : 15.4);
          final bodySize = availableInfoWidth < 118 ? 11.2 : 11.8;

          return SizedBox(
            height: 126,
            child: Row(
              children: [
                SizedBox(
                  width: logoWidth,
                  child: _UniversityLogo(kind: data.logoKind),
                ),
                Container(
                  width: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: AppPalette.divider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _UniversityInfo(
                    data: data,
                    titleSize: titleSize,
                    bodySize: bodySize,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: statsWidth,
                  child: _UniversityStats(
                    data: data,
                    shortlisted: shortlisted,
                    onShortlistTap: onShortlistTap,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UniversityInfo extends StatelessWidget {
  const _UniversityInfo({
    required this.data,
    required this.titleSize,
    required this.bodySize,
  });

  final _UniversityData data;
  final double titleSize;
  final double bodySize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          data.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppPalette.textStrong,
            fontSize: titleSize,
            fontWeight: FontWeight.w800,
            height: 0.98,
            letterSpacing: -0.35,
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${data.countryFlag} ',
                style: TextStyle(fontSize: bodySize + 0.8),
              ),
              TextSpan(
                text: data.location,
                style: TextStyle(
                  color: AppPalette.textMuted,
                  fontSize: bodySize,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.star_rounded,
              color: AppPalette.primary,
              size: bodySize + 6.4,
            ),
            const SizedBox(width: 3),
            Text(
              data.rating,
              style: TextStyle(
                color: AppPalette.textPrimary,
                fontSize: bodySize + 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                '(${data.reviews})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textSecondary,
                  fontSize: bodySize,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
          decoration: BoxDecoration(
            color: AppPalette.primarySoft,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            data.ranking,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppPalette.primaryDark,
              fontSize: bodySize - 0.4,
              fontWeight: FontWeight.w600,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _UniversityStats extends StatelessWidget {
  const _UniversityStats({
    required this.data,
    required this.shortlisted,
    required this.onShortlistTap,
  });

  final _UniversityData data;
  final bool shortlisted;
  final VoidCallback onShortlistTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 96;
        final labelStyle = TextStyle(
          color: AppPalette.textMuted,
          fontSize: compact ? 10.6 : 11.2,
          fontWeight: FontWeight.w500,
          height: 1.0,
        );
        final valueStyle = TextStyle(
          color: AppPalette.textPrimary,
          fontSize: compact ? 11.8 : 12.8,
          fontWeight: FontWeight.w700,
          height: 1.08,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onShortlistTap,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: compact ? 34 : 38,
                    height: compact ? 34 : 38,
                    decoration: BoxDecoration(
                      color: shortlisted
                          ? AppPalette.primarySoft
                          : AppPalette.surfaceSoft,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppPalette.border,
                      ),
                    ),
                    child: Icon(
                      shortlisted
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: shortlisted
                          ? AppPalette.primary
                          : AppPalette.textPrimary,
                      size: compact ? 17 : 19,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: compact ? 5 : 6),
            Text(
              'Tuition Fees',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
            const SizedBox(height: 3),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: data.tuitionFee, style: valueStyle),
                  TextSpan(
                    text: ' / year',
                    style: TextStyle(
                      color: AppPalette.textSecondary,
                      fontSize: compact ? 10.2 : 11.0,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: compact ? 10 : 12),
            Text(
              'Intake',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: labelStyle,
            ),
            const SizedBox(height: 3),
            Text(
              data.intake,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: valueStyle,
            ),
          ],
        );
      },
    );
  }
}

class _UniversityLogo extends StatelessWidget {
  const _UniversityLogo({required this.kind});

  final _UniversityLogoKind kind;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 86,
        height: 112,
        child: switch (kind) {
          _UniversityLogoKind.harvard => const _HarvardLogo(),
          _UniversityLogoKind.mit => const _MitLogo(),
          _UniversityLogoKind.oxford => const _OxfordLogo(),
          _UniversityLogoKind.nus => const _NusLogo(),
        },
      ),
    );
  }
}

class _HarvardLogo extends StatelessWidget {
  const _HarvardLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 62,
          decoration: const ShapeDecoration(
            color: Color(0xFFB63239),
            shape: _ShieldBorder(),
          ),
          child: const Center(
            child: Text(
              'VE\nRI\nTAS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.8,
                fontWeight: FontWeight.w800,
                height: 1.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'HARVARD',
          style: TextStyle(
            color: Color(0xFF1F1C19),
            fontSize: 13.2,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            height: 1.0,
          ),
        ),
        const Text(
          'UNIVERSITY',
          style: TextStyle(
            color: Color(0xFF1F1C19),
            fontSize: 7.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class _MitLogo extends StatelessWidget {
  const _MitLogo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MIT',
          style: TextStyle(
            color: Color(0xFFC92D3B),
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -2.2,
            height: 0.9,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Massachusetts\nInstitute of\nTechnology',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 10.2,
            fontWeight: FontWeight.w700,
            height: 1.12,
          ),
        ),
      ],
    );
  }
}

class _OxfordLogo extends StatelessWidget {
  const _OxfordLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF143D84),
            border: Border.all(
              color: const Color(0xFFE3B74A),
              width: 3,
            ),
          ),
          child: const Center(
            child: Text(
              'OX',
              style: TextStyle(
                color: Color(0xFFE7C36A),
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'UNIVERSITY OF',
          style: TextStyle(
            color: Color(0xFF21345B),
            fontSize: 6.8,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            height: 1.0,
          ),
        ),
        const Text(
          'OXFORD',
          style: TextStyle(
            color: Color(0xFF21345B),
            fontSize: 13.2,
            fontWeight: FontWeight.w500,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class _NusLogo extends StatelessWidget {
  const _NusLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFEA9A27),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'N',
                    style: TextStyle(
                      color: Color(0xFFEA8914),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'NUS',
                style: TextStyle(
                  color: Color(0xFF163E87),
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'National University\nof Singapore',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF294B7B),
            fontSize: 8.0,
            fontWeight: FontWeight.w600,
            height: 1.12,
          ),
        ),
      ],
    );
  }
}

class _AdviceCard extends StatelessWidget {
  const _AdviceCard();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final iconSize = compact ? 44.0 : 52.0;
        final buttonHorizontal = compact ? 12.0 : 18.0;
        final buttonVertical = compact ? 9.0 : 11.0;

        return Container(
          padding: EdgeInsets.fromLTRB(
            compact ? 14 : 18,
            compact ? 12 : 14,
            compact ? 14 : 18,
            compact ? 12 : 14,
          ),
          decoration: BoxDecoration(
            color: AppPalette.surface.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppPalette.shadow.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: iconSize,
                height: iconSize,
                decoration: const BoxDecoration(
                  color: AppPalette.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppPalette.primary,
                  size: 29,
                ),
              ),
              SizedBox(width: compact ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Need help choosing the right university?',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppPalette.textPrimary,
                        fontSize: compact ? 11.8 : 13.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.15,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Get personalized recommendations\nfrom our experts.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppPalette.textSecondary,
                        fontSize: compact ? 10.4 : 11.2,
                        fontWeight: FontWeight.w500,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: compact ? 10 : 12),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: buttonHorizontal,
                  vertical: buttonVertical,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Get Free Advice',
                  style: TextStyle(
                    color: AppPalette.surface,
                    fontSize: compact ? 11.2 : 12.4,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
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

class _FilterData {
  const _FilterData({
    required this.icon,
    required this.label,
    this.trailingIcon,
  });

  final IconData icon;
  final String label;
  final IconData? trailingIcon;
}

class _UniversityData {
  const _UniversityData({
    required this.id,
    required this.name,
    required this.countryFlag,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.ranking,
    required this.tuitionFee,
    required this.intake,
    required this.logoKind,
  });

  final String id;
  final String name;
  final String countryFlag;
  final String location;
  final String rating;
  final String reviews;
  final String ranking;
  final String tuitionFee;
  final String intake;
  final _UniversityLogoKind logoKind;
}

enum _UniversityLogoKind {
  harvard,
  mit,
  oxford,
  nus,
}

class _ShieldBorder extends ShapeBorder {
  const _ShieldBorder();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width * 0.12, rect.top)
      ..lineTo(rect.right - rect.width * 0.12, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + 8)
      ..lineTo(rect.right, rect.top + rect.height * 0.7)
      ..quadraticBezierTo(
        rect.right,
        rect.bottom - rect.height * 0.08,
        rect.center.dx,
        rect.bottom,
      )
      ..quadraticBezierTo(
        rect.left,
        rect.bottom - rect.height * 0.08,
        rect.left,
        rect.top + rect.height * 0.7,
      )
      ..lineTo(rect.left, rect.top + 8)
      ..quadraticBezierTo(
          rect.left, rect.top, rect.left + rect.width * 0.12, rect.top)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
