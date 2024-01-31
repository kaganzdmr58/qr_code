import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/globals/tools.dart';
import 'package:qr_code/globals/widgets/end_drawer.dart';
import 'package:qr_code/modules/scan_screen.dart/scan_screen.dart';

class AfterScanPage extends StatelessWidget {
  final BarcodeCapture capture;
  const AfterScanPage({super.key, required this.capture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('QR Code Info'),        
      ),
      endDrawer: const EndDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (final barcode in capture.barcodes)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: getScreenWidth(context),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.black, width: 2.0),
                        ),
                        child: Center(
                          child: Text(
                            getValueWithFormat(barcode),
                            style: const TextStyle(
                                fontSize: 20, color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      children: [
                        if (barcode.type == BarcodeType.url)
                          IconButton(
                            onPressed: () {
                              if (barcode.url?.url != null) {
                                opentUrl(barcode.url!.url);
                              }
                            },
                            icon: const Icon(Icons.web, size: 50),
                          ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: getValueWithFormat(barcode),
                              ),
                            );
                            showCustomSnackBar(context, 'Panoya kopyalandı');
                          },
                          icon: const Icon(Icons.copy, size: 50),
                        ),
                        IconButton(
                          onPressed: () {
                            gotoReplace(context, const ScanScreen());
                          },
                          icon: const Icon(Icons.qr_code_scanner, size: 50),
                        ),
                        /* if (barcode.type == BarcodeType.wifi)
                          IconButton(
                            onPressed: () async {
                              final val = connectWifi(barcode.rawValue ?? "");
                              if (val != null) {
                                await WiFiForIoTPlugin.connect(
                                  val[0],
                                  password: val[1],
                                );
                              }
                            },
                            icon: const Icon(Icons.wifi, size: 50),
                          ), */
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String>? connectWifi(String qrCode) {
  //String qrCode = 'WIFI:S:SUPERIOR;T:WPA;P:12345678;H:false;;';
  if (qrCode == "") return null;
  List<String> qrCodeSplit = qrCode.split(';');
  String ssid = qrCodeSplit[1].split(':')[1];
  String pwd = qrCodeSplit[2].split(':')[1];
  return [ssid, pwd];
}

String getValueWithFormat(Barcode barcode) {
  var val = "";

  switch (barcode.type) {
    case BarcodeType.email:
    case BarcodeType.text:
    case BarcodeType.phone:
    case BarcodeType.unknown:
    case BarcodeType.url:
    case BarcodeType.isbn:
      val = barcode.rawValue ?? "";
      break;
    case BarcodeType.contactInfo:
      break;
    case BarcodeType.product:
      break;
    case BarcodeType.sms:
      break;
    case BarcodeType.wifi:
      final v = connectWifi(barcode.rawValue ?? "");
      val = "Name : ${v?[0]}\nPassword : ${v?[1]}";
      break;
    case BarcodeType.geo:
      break;
    case BarcodeType.calendarEvent:
      break;
    case BarcodeType.driverLicense:
      break;
  }

  return val;
}
