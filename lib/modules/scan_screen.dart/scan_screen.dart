import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/globals/tools.dart';
import 'package:qr_code/globals/widgets/end_drawer.dart';
import 'package:qr_code/modules/afterscan/after_scan_page.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR_${DateTime.now()}');
  var sendState = true;

  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> gotoAfterScreen(BarcodeCapture capture) async {
      await Future.delayed(const Duration(milliseconds: 500));

      /* final List<Barcode> barcodes = capture.barcodes;
      final Uint8List? image = capture.image; */
      if (sendState == true) {
        gotoReplace(context, AfterScanPage(capture: capture));
        sendState = false;
      }
      cameraController.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('QR Code Scann'),
        actions: [],
      ),
      endDrawer: const EndDrawer(),
      body: Stack(
        children: [
          MobileScanner(
            key: qrKey,
            controller: cameraController,
            onDetect: (capture) => gotoAfterScreen(capture),
          ),
          Positioned(
            bottom: 100,
            right: 8,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.blue,
              child: Center(
                child: IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off);
                        case TorchState.on:
                          return const Icon(Icons.flash_on);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 164,
            right: 8,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.blue,
              child: IconButton(
                color: Colors.white,
                icon: ValueListenableBuilder(
                  valueListenable: cameraController.cameraFacingState,
                  builder: (context, state, child) {
                    switch (state) {
                      case CameraFacing.front:
                        return const Icon(Icons.camera_front);
                      case CameraFacing.back:
                        return const Icon(Icons.camera_rear);
                    }
                  },
                ),
                iconSize: 32.0,
                onPressed: () => cameraController.switchCamera(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
