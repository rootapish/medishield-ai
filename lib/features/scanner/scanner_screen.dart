import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:medishield_ai/core/routing/app_routes.dart';
import 'package:medishield_ai/core/services/medicine_database.dart';
import 'package:medishield_ai/core/models/scan_history_entry.dart';
import 'package:medishield_ai/core/models/medicine_record.dart';
import 'package:medishield_ai/core/services/scan_history_provider.dart';
import 'package:medishield_ai/core/theme/app_colors.dart';
import 'package:medishield_ai/core/theme/app_styles.dart';
import 'package:medishield_ai/widgets/app_scaffold.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleScanResult(String value) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    // Stop scanning
    _controller.stop();

    // Look up the scanned code in the mock database
    final record = MedicineDatabase.lookup(value);
    final status = record != null
        ? VerificationStatus.verified
        : VerificationStatus.suspicious;
    final medicineName = record?.medicineName ?? 'Unknown Medicine';

    // Record to scan history
    await context.read<ScanHistoryProvider>().addEntry(
          ScanHistoryEntry(
            batchId: value,
            scannedAt: DateTime.now(),
            status: status,
            medicineName: medicineName,
          ),
        );

    if (!mounted) return;

    // Navigate to Verify Batch and auto-verify
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.verify,
      arguments: VerifyRouteArgs(batchCode: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'AI Scanner',
      appBarTransparent: true,
      body: Stack(
        children: [
          // Camera View
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              onDetect: (capture) {
                if (_isProcessing) return;
                for (final barcode in capture.barcodes) {
                  final value = barcode.rawValue;
                  if (value != null && value.isNotEmpty) {
                    _handleScanResult(value);
                    break;
                  }
                }
              },
            ),
          ),
          
          // Overlay UI
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 20, right: 20), // Accounts for transparent AppScaffold appbar
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: AppStyles.cardBlur(24).copyWith(color: Colors.black45),
                          child: Row(
                            children: [
                              const Icon(Icons.psychology, color: AppColors.primaryContainer, size: 16),
                              const SizedBox(width: 8),
                              const Text('AI Active', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          decoration: AppStyles.cardBlur(24).copyWith(color: Colors.black45),
                          child: IconButton(
                            icon: ValueListenableBuilder(
                              valueListenable: _controller,
                              builder: (context, state, child) {
                                return Icon(
                                  state.torchState == TorchState.on ? Icons.flash_on : Icons.flash_off,
                                  color: Colors.white,
                                );
                              },
                            ),
                            onPressed: () => _controller.toggleTorch(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Scanning Target Overlay
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryContainer, width: 2),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      if (_isProcessing)
                        const CircularProgressIndicator(color: AppColors.primaryContainer),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Info Panel
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 100), // Leaves room for nav bar
                    padding: const EdgeInsets.all(20),
                    decoration: AppStyles.cardBlur(32).copyWith(color: Colors.white.withValues(alpha: 0.85)),
                    child: Column(
                      children: [
                        const Text('Align medicine packaging within frame', style: TextStyle(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _Indicator(icon: Icons.check_circle, label: 'Logo', color: Colors.green),
                            _Indicator(icon: Icons.check_circle, label: 'Text', color: Colors.green),
                            _Indicator(icon: Icons.pending, label: 'Hologram', color: Colors.orange),
                          ],
                        ),
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

class _Indicator extends StatelessWidget {
  const _Indicator({required this.icon, required this.label, required this.color});
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
