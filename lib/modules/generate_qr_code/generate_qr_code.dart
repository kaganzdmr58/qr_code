import 'package:flutter/material.dart';
import 'package:qr_code/globals/tools.dart';
import 'package:qr_code/globals/widgets/end_drawer.dart';
import 'package:qr_code/modules/generate_qr_code/widgets/wifi_edittext_widget.dart';
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

  String getWebUrl(String url){
    var newUrl = "";

    if(!url.contains("www.")){
      newUrl = "www.$url";
    }
    if(!url.contains("http")){
      newUrl = "https://$newUrl";
    }
    return newUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedValue,
                              items: [
                                'Web',
                                'Text',
                                'Wifi',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    height: 50.0,
                                    width: getScreenWidth(context) - 350,
                                    child: Center(
                                      child: Text(value),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  qrCodeText = "";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (selectedValue == "Text" || selectedValue == "Web")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: getScreenWidth(context),
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            onChanged: (val) {
                              if (selectedValue == "Web") {
                                qrCodeText = getWebUrl(val);
                              } else {
                                qrCodeText = val;
                              }
                            },
                            maxLines: 10,
                            controller: _textEditingController,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (selectedValue == "Wifi")
                  WifiEdittextWidget(
                    initialValue: qrCodeText,
                    functionValue: (val) {
                      qrCodeText = val;
                    },
                  ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.blue.shade400;
                            }
                            return Colors.blue.shade400;
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        "Qr Kod Oluştur".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
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
