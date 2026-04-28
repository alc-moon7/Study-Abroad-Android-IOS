import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_theme.dart';

class ApplicationFormScreen extends StatelessWidget {
  const ApplicationFormScreen({
    super.key,
    required this.universityName,
    required this.programName,
  });

  final String universityName;
  final String programName;

  static const List<_ApplicationFormSectionData> _sections = [
    _ApplicationFormSectionData(
      title: 'PASSPORT & CSC FIELDS',
      items: [
        _ApplicationFormItemData(title: '1. Valid Passport'),
        _ApplicationFormItemData(title: '2. Updated CV / Resume'),
      ],
    ),
    _ApplicationFormSectionData(
      title: 'CERTIFICATES & TRANSCRIPTS',
      items: [
        _ApplicationFormItemData(title: '3a. SSC Certificate'),
        _ApplicationFormItemData(title: '3b. SSC Transcript'),
        _ApplicationFormItemData(title: '4a. HSC Certificate'),
        _ApplicationFormItemData(title: '4b. HSC Transcript'),
        _ApplicationFormItemData(title: '5a. Bachelor Certificate'),
        _ApplicationFormItemData(title: '5b. Bachelor Transcript'),
        _ApplicationFormItemData(title: "6a. Master's Certificate"),
        _ApplicationFormItemData(title: "6b. Master's Transcript"),
      ],
    ),
    _ApplicationFormSectionData(
      title: 'RECOMMENDATIONS',
      items: [
        _ApplicationFormItemData(title: '7a. Academic Recommendation (1)'),
        _ApplicationFormItemData(title: '7b. Academic Recommendation (2)'),
        _ApplicationFormItemData(title: '8. Job Recommendation'),
      ],
    ),
    _ApplicationFormSectionData(
      title: 'ENGLISH TEST & STATEMENT OF PURPOSE',
      note:
          'Upload English proficiency test if required by your chosen program, plus a final statement of purpose.',
      items: [
        _ApplicationFormItemData(
          title: '9. English Proficiency',
          helper: 'IELTS / TOEFL / Duolingo / MOI accepted where applicable.',
        ),
        _ApplicationFormItemData(title: '10. Statement of Purpose'),
      ],
    ),
  ];

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
            child: ListView(
              padding: const EdgeInsets.only(top: 12, bottom: 24),
              children: [
                _ApplicationTopBar(onBack: () => Navigator.of(context).pop()),
                const SizedBox(height: 14),
                _ApplicationHeader(
                  universityName: universityName,
                  programName: programName,
                ),
                const SizedBox(height: 14),
                const _InstructionCard(),
                const SizedBox(height: 14),
                ..._sections.map(
                  (section) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _ApplicationSection(data: section),
                  ),
                ),
                const _SubmitApplicationButton(),
                const SizedBox(height: 12),
                Text(
                  '$universityName | Application documents are securely prepared',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppPalette.textMuted,
                    fontSize: 10.8,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
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

class _ApplicationTopBar extends StatelessWidget {
  const _ApplicationTopBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CircleIconButton(
          icon: Icons.arrow_back_rounded,
          onTap: onBack,
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Study Abroad',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 14.2,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
        const _CircleIconButton(icon: Icons.more_horiz_rounded),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
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
        customBorder: const CircleBorder(),
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppPalette.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppPalette.border),
            boxShadow: [
              BoxShadow(
                color: AppPalette.shadow.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppPalette.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ApplicationHeader extends StatelessWidget {
  const _ApplicationHeader({
    required this.universityName,
    required this.programName,
  });

  final String universityName;
  final String programName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleSize =
            (constraints.maxWidth * 0.074).clamp(25.0, 34.0).toDouble();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          decoration: BoxDecoration(
            color: AppPalette.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: AppPalette.border),
            boxShadow: [
              BoxShadow(
                color: AppPalette.shadow.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'STUDY ABROAD APP',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.labelMuted,
                  fontSize: 10.4,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Application form',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppPalette.textPrimary,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w900,
                  height: 0.98,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Submit required documents and complete application to $universityName.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppPalette.textSecondary,
                  fontSize: 13.2,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              _ProgramPill(label: programName),
            ],
          ),
        );
      },
    );
  }
}

class _ProgramPill extends StatelessWidget {
  const _ProgramPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: AppPalette.surfaceTint,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.border),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppPalette.textSecondary,
          fontSize: 11.4,
          fontWeight: FontWeight.w800,
          height: 1.0,
        ),
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  const _InstructionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppPalette.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.border),
      ),
      child: const Text(
        'Please fill the documents below. Select one or more methods to upload each file.',
        style: TextStyle(
          color: AppPalette.textSecondary,
          fontSize: 12.4,
          fontWeight: FontWeight.w600,
          height: 1.35,
        ),
      ),
    );
  }
}

class _ApplicationSection extends StatelessWidget {
  const _ApplicationSection({required this.data});

  final _ApplicationFormSectionData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppPalette.border),
        boxShadow: [
          BoxShadow(
            color: AppPalette.shadow.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppPalette.primaryDark,
                fontSize: 10.2,
                fontWeight: FontWeight.w900,
                height: 1.1,
                letterSpacing: 1.2,
              ),
            ),
          ),
          if (data.note != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                data.note!,
                style: const TextStyle(
                  color: AppPalette.textSecondary,
                  fontSize: 11.4,
                  fontWeight: FontWeight.w500,
                  height: 1.32,
                ),
              ),
            ),
          ],
          const SizedBox(height: 10),
          ...data.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _UploadDocumentCard(data: item),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadDocumentCard extends StatelessWidget {
  const _UploadDocumentCard({required this.data});

  final _ApplicationFormItemData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
      decoration: BoxDecoration(
        color: AppPalette.surfaceSoft,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppPalette.textPrimary,
                    fontSize: 12.6,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const _DemoPill(),
              const SizedBox(width: 6),
              const Icon(
                Icons.info_outline_rounded,
                color: AppPalette.textMuted,
                size: 16,
              ),
            ],
          ),
          if (data.helper != null) ...[
            const SizedBox(height: 7),
            Text(
              data.helper!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppPalette.textMuted,
                fontSize: 10.8,
                fontWeight: FontWeight.w500,
                height: 1.25,
              ),
            ),
          ],
          const SizedBox(height: 10),
          const Row(
            children: [
              _ChooseFileButton(),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'No file chosen',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppPalette.textMuted,
                    fontSize: 11.2,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DemoPill extends StatelessWidget {
  const _DemoPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppPalette.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppPalette.border),
      ),
      child: const Text(
        'Demo',
        style: TextStyle(
          color: AppPalette.textSecondary,
          fontSize: 9.8,
          fontWeight: FontWeight.w800,
          height: 1.0,
        ),
      ),
    );
  }
}

class _ChooseFileButton extends StatelessWidget {
  const _ChooseFileButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(999),
          ),
          child: const Text(
            'Choose file',
            style: TextStyle(
              color: AppPalette.surface,
              fontSize: 10.8,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitApplicationButton extends StatelessWidget {
  const _SubmitApplicationButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: AppPalette.primary,
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: AppPalette.shadow.withValues(alpha: 0.10),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Text(
            'Submit application',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppPalette.surface,
              fontSize: 13.0,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class _ApplicationFormSectionData {
  const _ApplicationFormSectionData({
    required this.title,
    required this.items,
    this.note,
  });

  final String title;
  final List<_ApplicationFormItemData> items;
  final String? note;
}

class _ApplicationFormItemData {
  const _ApplicationFormItemData({
    required this.title,
    this.helper,
  });

  final String title;
  final String? helper;
}
