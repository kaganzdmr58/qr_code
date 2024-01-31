import 'package:flutter/material.dart';
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
  var qrCodeText = "";
  String selectedValue = 'Web';
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RepaintBoundary(
                      key: _globalKey,
                      child: QrImageView(
                        backgroundColor: Colors.white,
                        data: qrCodeText,
                        size: 200,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*  Row(
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
                                onPressed: () => saveQRImage(),
                                icon: const Icon(
                                  Icons.share,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ), */
                          DropdownButton<String>(
                            value: selectedValue,
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Web',
                                child: Text('Web'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Text',
                                child: Text('Text'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Wifi',
                                child: Text('Wifi'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!;
                              });
                            },
                          ),
                        //  MyDropdownButton(),
                        ],
                      ),
                    ),
                  ],
                ),
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
                      child: TextField(
                        controller: _textEditingController,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.blue),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          qrCodeText = _textEditingController.text;
                        });
                      },
                      child: Text("Qr Kod Oluştur".toUpperCase()),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
