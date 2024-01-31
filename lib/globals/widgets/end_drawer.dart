import 'package:flutter/material.dart';
import 'package:qr_code/globals/tools.dart';
import 'package:qr_code/modules/generate_qr_code/generate_qr_code.dart';
import 'package:qr_code/modules/scan_screen.dart/scan_screen.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'QR Code Scann, Genrate and Connnect Web',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Qr Code Generate'),
            onTap: () {
              gotoReplace(context, const GenerateQrCode());
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code_scanner_sharp),
            title: const Text('Scann Barcode'),
            onTap: () {
              gotoReplace(context, const ScanScreen());
            },
          ),
          /* ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ), */
        ],
      ),
    );
  }
}
