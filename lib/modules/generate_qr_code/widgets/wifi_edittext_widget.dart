import 'package:flutter/material.dart';
import 'package:qr_code/globals/tools.dart';

class WifiEdittextWidget extends StatelessWidget {
  final String? initialValue;
  final Function(String) functionValue;
  WifiEdittextWidget(
      {super.key, required this.functionValue,  this.initialValue});

  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _textEditingControllerPwd =
      TextEditingController();

  void connectWifi() {
    //String qrCode = 'WIFI:S:SUPERIOR;T:WPA;P:12345678;H:false;;';
    if(initialValue == null || initialValue == "") return;
    List<String> qrCodeSplit = initialValue!.split(';');
    String ssid = qrCodeSplit[0].split(':')[2];
    String pwd = qrCodeSplit[2].split(':')[1];
    _textEditingController.text = ssid;
    _textEditingControllerPwd.text = pwd;
  }

  void sendFuntion() {
    functionValue(
        "WIFI:S:${_textEditingController.text};T:WPA;P:${_textEditingControllerPwd.text};H:false;;");
  }

  @override
  Widget build(BuildContext context) {
    connectWifi();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: getScreenWidth(context),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("SSID :"),
                  SizedBox(
                    width: getScreenWidth(context) - 110,
                    child: TextField(
                      maxLength: 100,
                      onChanged: (value) {
                        sendFuntion();
                      },
                      controller: _textEditingController,
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all( 8.0),
          child: Container(
            width: getScreenWidth(context),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Password :"),
                  SizedBox(
                    width: getScreenWidth(context) - 110,
                    child: TextField(
                      maxLength: 100,
                      onChanged: (value) {
                        sendFuntion();
                      },
                      controller: _textEditingControllerPwd,
                      style: const TextStyle(fontSize: 20, color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
