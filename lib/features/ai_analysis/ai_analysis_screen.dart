import 'package:flutter/material.dart';
import 'package:medishield_ai/core/constants/app_constants.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

// ---------------------------------------------------------------------------
// Mock analysis result — replace the _runMockAnalysis body with a real
// Gemini API call when integrating. The [AnalysisReport] model stays the same.
// ---------------------------------------------------------------------------

class AnalysisReport {
  const AnalysisReport({
    required this.score,
    required this.riskLevel,
    required this.checks,
    required this.warnings,
  });

  final int score; // 0–100
  final String riskLevel; // LOW | MEDIUM | HIGH
  final List<String> checks; // passed checks
  final List<String> warnings; // flagged issues
}

AnalysisReport _runMockAnalysis() {
  // TODO: Replace with Gemini Vision API call.
  // Input: image bytes from _selectedImageBytes
  // Output: parse JSON response into AnalysisReport
  return const AnalysisReport(
    score: 87,
    riskLevel: 'LOW',
    checks: [
      'Logo Match',
      'Color Consistency',
      'Packaging Quality',
      'Seal Integrity',
    ],
    warnings: [
      'Typography Variation Detected',
    ],
  );
}

// ---------------------------------------------------------------------------

enum _ImageState { none, selected, analyzing, done }

class AiAnalysisScreen extends StatefulWidget {
  const AiAnalysisScreen({super.key});

  @override
  State<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends State<AiAnalysisScreen> {
  _ImageState _imageState = _ImageState.none;
  String _imageLabel = '';
  AnalysisReport? _report;

  void _simulateImageSelection(String source) {
    setState(() {
      _imageState = _ImageState.selected;
      _imageLabel = source == 'camera'
          ? 'Photo captured from camera'
          : 'Image selected from gallery';
      _report = null;
    });
  }

  Future<void> _analyze() async {
    if (_imageState == _ImageState.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select or capture an image first.'),
        ),
      );
      return;
    }

    setState(() => _imageState = _ImageState.analyzing);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // TODO: swap with actual Gemini call
    final report = _runMockAnalysis();

    setState(() {
      _imageState = _ImageState.done;
      _report = report;
    });
  }

  void _reset() {
    setState(() {
      _imageState = _ImageState.none;
      _imageLabel = '';
      _report = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'AI Analysis',
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // ── Image picker area ────────────────────────────────────────
          _ImagePickerArea(
            imageState: _imageState,
            imageLabel: _imageLabel,
            onCamera: () => _simulateImageSelection('camera'),
            onGallery: () => _simulateImageSelection('gallery'),
            onReset: _reset,
          ),

          const SizedBox(height: AppConstants.spacingMd),

          // ── Analyze button ───────────────────────────────────────────
          FilledButton.icon(
            onPressed: _imageState == _ImageState.analyzing ? null : _analyze,
            icon: _imageState == _ImageState.analyzing
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.psychology_outlined),
            label: Text(_imageState == _ImageState.analyzing
                ? 'Analyzing…'
                : 'Analyze Packaging'),
          ),

          const SizedBox(height: AppConstants.spacingLg),

          // ── Report ──────────────────────────────────────────────────
          if (_report != null) _ReportCard(report: _report!),
        ],
      ),
    );
  }
}

// ── Image picker area ─────────────────────────────────────────────────────────

class _ImagePickerArea extends StatelessWidget {
  const _ImagePickerArea({
    required this.imageState,
    required this.imageLabel,
    required this.onCamera,
    required this.onGallery,
    required this.onReset,
  });

  final _ImageState imageState;
  final String imageLabel;
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final hasImage = imageState != _ImageState.none;

    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: hasImage
              ? cs.primary.withValues(alpha: 0.6)
              : cs.outlineVariant,
          width: hasImage ? 2 : 1,
        ),
      ),
      child: hasImage
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_outlined, size: 48, color: cs.primary),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  imageLabel,
                  style: tt.bodySmall
                      ?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: AppConstants.spacingXs),
                TextButton.icon(
                  onPressed: onReset,
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Remove'),
                  style: TextButton.styleFrom(
                    foregroundColor: cs.error,
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_outlined,
                    size: 48, color: cs.onSurfaceVariant),
                const SizedBox(height: AppConstants.spacingSm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: onCamera,
                      icon: const Icon(Icons.camera_alt_outlined, size: 16),
                      label: const Text('Capture'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingSm),
                    OutlinedButton.icon(
                      onPressed: onGallery,
                      icon: const Icon(Icons.photo_library_outlined, size: 16),
                      label: const Text('Upload'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

// ── Report card ───────────────────────────────────────────────────────────────

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report});
  final AnalysisReport report;

  Color _riskColor(String level) {
    return switch (level.toUpperCase()) {
      'LOW' => Colors.green.shade600,
      'MEDIUM' => Colors.orange.shade600,
      _ => Colors.red.shade600,
    };
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final riskColor = _riskColor(report.riskLevel);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.analytics_outlined, color: cs.primary),
                const SizedBox(width: AppConstants.spacingSm),
                Text(
                  'Packaging Analysis Report',
                  style: tt.titleMedium,
                ),
              ],
            ),
            const Divider(height: AppConstants.spacingLg),

            // Authenticity Score
            Center(
              child: Column(
                children: [
                  Text('Authenticity Score', style: tt.labelMedium),
                  const SizedBox(height: AppConstants.spacingSm),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: report.score / 100,
                          strokeWidth: 10,
                          backgroundColor:
                              cs.surfaceContainerHighest,
                          color: cs.primary,
                        ),
                      ),
                      Text(
                        '${report.score}%',
                        style: tt.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacingLg),

            // Passed checks
            Text('Checks', style: tt.titleSmall),
            const SizedBox(height: AppConstants.spacingXs),
            ...report.checks.map(
              (c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline,
                        color: Colors.green.shade600, size: 18),
                    const SizedBox(width: AppConstants.spacingXs),
                    Text(c, style: tt.bodyMedium),
                  ],
                ),
              ),
            ),

            if (report.warnings.isNotEmpty) ...[
              const SizedBox(height: AppConstants.spacingSm),
              ...report.warnings.map(
                (w) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange.shade600, size: 18),
                      const SizedBox(width: AppConstants.spacingXs),
                      Expanded(child: Text(w, style: tt.bodyMedium)),
                    ],
                  ),
                ),
              ),
            ],

            const Divider(height: AppConstants.spacingLg),

            // Risk level
            Row(
              children: [
                Text('Risk Level:', style: tt.bodyMedium),
                const SizedBox(width: AppConstants.spacingSm),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: riskColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    report.riskLevel,
                    style: tt.labelLarge?.copyWith(
                      color: riskColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppConstants.spacingXs),
            Text(
              'Analysis powered by AI (mock). Connect Gemini Vision API for real analysis.',
              style: tt.bodySmall
                  ?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
