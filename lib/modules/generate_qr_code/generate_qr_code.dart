import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_code/globals/tools.dart';
import 'package:qr_code/globals/widgets/end_drawer.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrCode extends StatefulWidget {
  const GenerateQrCode({super.key});

  @override
  State<GenerateQrCode> createState() => _GenerateQrCodeState();
}

class _GenerateQrCodeState extends State<GenerateQrCode> {
  final GlobalKey _globalKey = GlobalKey();
  String selectedValue = 'Option 1';

  Future<void> _saveQRCode(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image? image = await boundary.toImage(pixelRatio: 3.0);

      if (image != null) {
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);

        if (byteData != null) {
          Uint8List pngBytes = byteData.buffer.asUint8List();
          final result = await ImageGallerySaver.saveImage(
              Uint8List.fromList(pngBytes),
              quality: 60,
              name: "deneme 11");
          print(result);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('QR Kodu başarıyla indirildi.'),
          ));
        } else {
          throw 'ByteData is null';
        }
      } else {
        throw 'Image is null';
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('QR Kodunu indirirken bir hata oluştu.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Generate QR Code'),
      ),
      endDrawer: const EndDrawer(),
      body: SafeArea(
        child: SizedBox(
          width: getScreenWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RepaintBoundary(
                    key: _globalKey,
                    child: QrImageView(
                      backgroundColor: Colors.white,
                      data: "Table qr code",
                      size: 200,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _saveQRCode(context),
                              icon: const Icon(
                                Icons.save,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _saveQRCode(context),
                              icon: const Icon(
                                Icons.share,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: selectedValue,
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'Option 1',
                              child: Text('Option 1'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Option 2',
                              child: Text('Option 2'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Option 3',
                              child: Text('Option 3'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
