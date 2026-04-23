import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'study_bottom_bar.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _selectedSortIndex = 0;
  int _selectedCategoryIndex = 0;

  static const List<String> _sortTabs = ['Best', 'Hot', 'New', 'Top'];

  static const List<_CommunityCategoryData> _categories = [
    _CommunityCategoryData(
      label: 'All',
      icon: Icons.grid_view_rounded,
      active: true,
    ),
    _CommunityCategoryData(
      label: 'General',
      icon: Icons.chat_bubble_outline_rounded,
    ),
    _CommunityCategoryData(
      label: 'Scholarships',
      icon: Icons.school_outlined,
    ),
    _CommunityCategoryData(
      label: 'Universities',
      icon: Icons.account_balance_outlined,
    ),
    _CommunityCategoryData(
      label: 'Visa',
      icon: Icons.badge_outlined,
    ),
  ];

  static const List<_CommunityPostData> _posts = [
    _CommunityPostData(
      authorName: 'Rohan Ahmed',
      metaLine: 'Student • University of Toronto, Canada',
      timeLabel: '2h ago',
      title: 'Planning to Study in Canada - Need Advice!',
      body:
          "I'm planning for Fall 2025 intake in Canada for MS in Computer Science. Need suggestions on universities and scholarship opportunities. Any help would be appreciated!",
      tag: 'Canada',
      tagBackground: Color(0xFFFFF0E3),
      tagForeground: Color(0xFFEE781B),
      reactionCount: '128',
      comments: '45 Comments',
      shares: '12 Shares',
      accentBadge: 'Top Contributor',
      avatarKind: _CommunityAvatarKind.rohan,
    ),
    _CommunityPostData(
      authorName: 'Anika Rahman',
      metaLine: 'Student • University of Melbourne, Australia',
      timeLabel: '5h ago',
      title: 'Scholarships for International Students in Australia',
      body:
          'Sharing a list of fully funded scholarships in Australia that I found helpful. Hope this helps someone!',
      tag: 'Scholarship',
      tagBackground: Color(0xFFEDEBFF),
      tagForeground: Color(0xFF5F57E8),
      reactionCount: '96',
      comments: '32 Comments',
      shares: '8 Shares',
      avatarKind: _CommunityAvatarKind.anika,
    ),
    _CommunityPostData(
      authorName: 'StudyAbroad Insider',
      metaLine: 'Official • 1d ago',
      timeLabel: '1d ago',
      title: 'Top 10 Countries to Study Abroad in 2025',
      body:
          'Explore the best study abroad destinations for international students based on quality of education, cost, and opportunities.',
      tag: 'Official',
      tagBackground: Color(0xFFFFEFE2),
      tagForeground: Color(0xFFEC7B1F),
      reactionCount: '204',
      comments: '68 Comments',
      shares: '29 Shares',
      avatarKind: _CommunityAvatarKind.official,
      showFeatureImage: true,
      verified: true,
    ),
  ];

  void _onBottomTabSelected(StudyBottomTab tab) {
    if (tab == StudyBottomTab.community) {
      return;
    }
    if (tab == StudyBottomTab.universities) {
      Navigator.of(context).maybePop();
    }
  }

  void _goBack() {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.92, -1.0),
              end: Alignment(1.0, 1.0),
              colors: [
                Color(0xFFFFCB32),
                Color(0xFFFFAA1F),
                Color(0xFFFF9120),
              ],
              stops: [0.0, 0.68, 1.0],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _CommunityBackground(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 264,
                            child: Stack(
                              children: [
                                _CommunityHeroSection(onBack: _goBack),
                                const Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: _CommunityComposerCard(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          _CommunitySortRow(
                            selectedIndex: _selectedSortIndex,
                            onSelected: (index) {
                              setState(() {
                                _selectedSortIndex = index;
                              });
                            },
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 54,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: _categories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                final selected =
                                    _selectedCategoryIndex == index ||
                                    (index == 0 && category.active);
                                return _CommunityCategoryChip(
                                  data: category,
                                  selected: selected,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.only(bottom: 122),
                              itemCount: _posts.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemBuilder: (context, index) {
                                return _CommunityPostCard(data: _posts[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 6,
                        bottom: 102,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            customBorder: const CircleBorder(),
                            child: Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9B0B),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFA04800).withOpacity(
                                      0.20,
                                    ),
                                    blurRadius: 18,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.add_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 10,
                        child: StudyBottomBar(
                          activeTab: StudyBottomTab.community,
                          onTabSelected: _onBottomTabSelected,
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

class _CommunityBackground extends StatelessWidget {
  const _CommunityBackground();

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
                      Colors.white.withOpacity(0.03),
                      Colors.white.withOpacity(0.16),
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
                  color: Colors.white.withOpacity(0.08),
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
                    Color(0x20FFFFFF),
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

class _CommunityHeroSection extends StatelessWidget {
  const _CommunityHeroSection({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final titleSize = (width * 0.095).clamp(28.0, 40.0).toDouble();
        final subtitleSize = (width * 0.048).clamp(16.0, 20.0).toDouble();

        return SizedBox(
          height: 222,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: 6,
                child: _HeroCircleButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: onBack,
                ),
              ),
              const Positioned(
                right: 0,
                top: 6,
                child: _HeroCircleButton(
                  icon: Icons.more_vert_rounded,
                ),
              ),
              Positioned(
                right: -6,
                bottom: 18,
                child: Image.asset(
                  'assets/icon/community_fox.png',
                  width: (width * 0.41).clamp(170.0, 228.0).toDouble(),
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                left: 0,
                top: 74,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width * 0.58),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Community',
                        style: TextStyle(
                          color: const Color(0xFF1E1A12),
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          height: 0.96,
                          letterSpacing: -0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Learn. Share. Grow together.',
                        style: TextStyle(
                          color: const Color(0xFF3B2C12),
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

class _HeroCircleButton extends StatelessWidget {
  const _HeroCircleButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.28),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2A241C),
            size: 24,
          ),
        ),
      ),
    );
  }
}

class _CommunityComposerCard extends StatelessWidget {
  const _CommunityComposerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.985),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7A3F00).withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF0CB),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: ClipOval(
                child: Image.asset(
                  'assets/icon/community_fox.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "What’s on your mind?",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF8A8782),
                fontSize: 16.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF0E1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.edit_rounded,
                  color: Color(0xFFFF8710),
                  size: 22,
                ),
                SizedBox(width: 8),
                Text(
                  'Post',
                  style: TextStyle(
                    color: Color(0xFFF5790F),
                    fontSize: 15.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommunitySortRow extends StatelessWidget {
  const _CommunitySortRow({
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.985),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7A3F00).withOpacity(0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_CommunityPageState._sortTabs.length, (
                index,
              ) {
                final selected = selectedIndex == index;
                return Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onSelected(index),
                      borderRadius: BorderRadius.circular(18),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _CommunityPageState._sortTabs[index],
                              style: TextStyle(
                                color: selected
                                    ? const Color(0xFFF47C11)
                                    : const Color(0xFF1F1D23),
                                fontSize: 14.0,
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              width: selected ? 44 : 0,
                              height: 3.2,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF47C11),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF1D0).withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.filter_alt_outlined,
                color: Color(0xFF2B2B2B),
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Filters',
                style: TextStyle(
                  color: Color(0xFF252321),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFFF8B06),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(width: 8, height: 8),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommunityCategoryChip extends StatelessWidget {
  const _CommunityCategoryChip({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _CommunityCategoryData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFFF8A0A)
                : Colors.white.withOpacity(0.97),
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: Colors.white, width: 2.6)
                : Border.all(color: Colors.white.withOpacity(0.44)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.icon,
                size: 22,
                color: selected
                    ? Colors.white
                    : const Color(0xFF2C2A28),
              ),
              const SizedBox(width: 10),
              Text(
                data.label,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF2C2A28),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommunityPostCard extends StatelessWidget {
  const _CommunityPostCard({required this.data});

  final _CommunityPostData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.985),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7A3F00).withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CommunityAvatar(kind: data.avatarKind),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(
                          data.authorName,
                          style: const TextStyle(
                            color: Color(0xFF23212A),
                            fontSize: 16.2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (data.verified)
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF2E8EFF),
                            size: 18,
                          ),
                        if (data.accentBadge != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF0E2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              data.accentBadge!,
                              style: const TextStyle(
                                color: Color(0xFFF18118),
                                fontSize: 11.8,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.metaLine,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF69646A),
                        fontSize: 13.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          data.timeLabel,
                          style: const TextStyle(
                            color: Color(0xFF6F6A71),
                            fontSize: 12.6,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.public_rounded,
                          color: Color(0xFF706A72),
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Color(0xFF5B5755),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.title,
            style: const TextStyle(
              color: Color(0xFF1F1D27),
              fontSize: 19,
              fontWeight: FontWeight.w800,
              height: 1.08,
              letterSpacing: -0.25,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.body,
            style: const TextStyle(
              color: Color(0xFF3C3947),
              fontSize: 14.4,
              fontWeight: FontWeight.w500,
              height: 1.36,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: data.tagBackground,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              data.tag,
              style: TextStyle(
                color: data.tagForeground,
                fontSize: 12.4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (data.showFeatureImage) ...[
            const SizedBox(height: 14),
            const _CommunityTravelBanner(),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              const _ReactionCluster(),
              const SizedBox(width: 10),
              Text(
                data.reactionCount,
                style: const TextStyle(
                  color: Color(0xFF4A4651),
                  fontSize: 13.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                data.comments,
                style: const TextStyle(
                  color: Color(0xFF5A5661),
                  fontSize: 13.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                data.shares,
                style: const TextStyle(
                  color: Color(0xFF5A5661),
                  fontSize: 13.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: const Color(0xFFEAE3D9).withOpacity(0.8),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _PostAction(
                  icon: Icons.thumb_up_alt_outlined,
                  label: 'Like',
                ),
              ),
              Expanded(
                child: _PostAction(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Comment',
                ),
              ),
              Expanded(
                child: _PostAction(
                  icon: Icons.reply_rounded,
                  label: 'Share',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReactionCluster extends StatelessWidget {
  const _ReactionCluster();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Stack(
        clipBehavior: Clip.none,
        children: const [
          _ReactionBubble(
            left: 0,
            background: Color(0xFF2E8EFF),
            child: Icon(Icons.thumb_up_alt_rounded, color: Colors.white, size: 15),
          ),
          _ReactionBubble(
            left: 20,
            background: Color(0xFFFF5E5E),
            child: Icon(Icons.favorite_rounded, color: Colors.white, size: 15),
          ),
          _ReactionBubble(
            left: 40,
            background: Color(0xFFFFD449),
            child: Text(
              '😮',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReactionBubble extends StatelessWidget {
  const _ReactionBubble({
    required this.left,
    required this.background,
    required this.child,
  });

  final double left;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(0xFF605A63),
          size: 28,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5F5962),
            fontSize: 13.4,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _CommunityTravelBanner extends StatelessWidget {
  const _CommunityTravelBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 198,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8DCCFF),
              Color(0xFFE4F3FF),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 18,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 22,
              right: 26,
              child: Icon(
                Icons.flight_rounded,
                color: Colors.white.withOpacity(0.94),
                size: 30,
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _LandmarkBlock(
                    width: 54,
                    height: 120,
                    color: const Color(0xFF4A7CB0),
                    child: const Icon(
                      Icons.account_balance_rounded,
                      color: Color(0xFFEFD16C),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  _ClockTower(),
                  const SizedBox(width: 18),
                  _OperaHouse(),
                  const Spacer(),
                  _NeedleTower(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LandmarkBlock extends StatelessWidget {
  const _LandmarkBlock({
    required this.width,
    required this.height,
    required this.color,
    required this.child,
  });

  final double width;
  final double height;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Center(child: child),
    );
  }
}

class _ClockTower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 104,
          decoration: const BoxDecoration(
            color: Color(0xFFB28744),
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9EBC7),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OperaHouse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 70,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: _Sail(width: 36, height: 44),
          ),
          Positioned(
            bottom: 0,
            child: _Sail(width: 42, height: 52),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: _Sail(width: 34, height: 40),
          ),
        ],
      ),
    );
  }
}

class _Sail extends StatelessWidget {
  const _Sail({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _SailClipper(),
      child: Container(
        width: width,
        height: height,
        color: const Color(0xFFEFEAE4),
      ),
    );
  }
}

class _SailClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.18,
      size.width,
      0,
    );
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _NeedleTower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 10,
          height: 116,
          decoration: BoxDecoration(
            color: const Color(0xFF746C73),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        Container(
          width: 40,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFF746C73),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ],
    );
  }
}

class _CommunityAvatar extends StatelessWidget {
  const _CommunityAvatar({required this.kind});

  final _CommunityAvatarKind kind;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: switch (kind) {
        _CommunityAvatarKind.rohan => const _IllustratedAvatar(
          hairColor: Color(0xFF2D211E),
          shirtColor: Color(0xFFF2A126),
          background1: Color(0xFFE4D7CC),
          background2: Color(0xFFC5B08F),
        ),
        _CommunityAvatarKind.anika => const _IllustratedAvatar(
          hairColor: Color(0xFF4D342B),
          shirtColor: Color(0xFFDBC8A7),
          background1: Color(0xFFF0E4D9),
          background2: Color(0xFFC9B18E),
          feminine: true,
        ),
        _CommunityAvatarKind.official => ClipOval(
          child: Container(
            color: const Color(0xFFFFF0CB),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              'assets/icon/community_fox.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      },
    );
  }
}

class _IllustratedAvatar extends StatelessWidget {
  const _IllustratedAvatar({
    required this.hairColor,
    required this.shirtColor,
    required this.background1,
    required this.background2,
    this.feminine = false,
  });

  final Color hairColor;
  final Color shirtColor;
  final Color background1;
  final Color background2;
  final bool feminine;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [background1, background2],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            right: 8,
            bottom: 6,
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                color: shirtColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            top: 15,
            child: Container(
              height: 22,
              decoration: const BoxDecoration(
                color: Color(0xFFF3C39D),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: feminine ? 10 : 14,
            right: feminine ? 10 : 14,
            top: 8,
            child: Container(
              height: feminine ? 28 : 18,
              decoration: BoxDecoration(
                color: hairColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          if (feminine) ...[
            Positioned(
              left: 9,
              top: 22,
              bottom: 12,
              child: Container(
                width: 9,
                decoration: BoxDecoration(
                  color: hairColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              right: 9,
              top: 22,
              bottom: 12,
              child: Container(
                width: 9,
                decoration: BoxDecoration(
                  color: hairColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CommunityCategoryData {
  const _CommunityCategoryData({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;
}

class _CommunityPostData {
  const _CommunityPostData({
    required this.authorName,
    required this.metaLine,
    required this.timeLabel,
    required this.title,
    required this.body,
    required this.tag,
    required this.tagBackground,
    required this.tagForeground,
    required this.reactionCount,
    required this.comments,
    required this.shares,
    required this.avatarKind,
    this.accentBadge,
    this.verified = false,
    this.showFeatureImage = false,
  });

  final String authorName;
  final String metaLine;
  final String timeLabel;
  final String title;
  final String body;
  final String tag;
  final Color tagBackground;
  final Color tagForeground;
  final String reactionCount;
  final String comments;
  final String shares;
  final String? accentBadge;
  final bool verified;
  final bool showFeatureImage;
  final _CommunityAvatarKind avatarKind;
}

enum _CommunityAvatarKind {
  rohan,
  anika,
  official,
}
