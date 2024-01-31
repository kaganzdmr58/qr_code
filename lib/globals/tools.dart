import 'package:flutter/material.dart';
import 'package:qr_code/globals/widgets/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

goto(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

gotoReplace(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double getSafeAreaHead(BuildContext context) {
  EdgeInsets safeAreaPadding = MediaQuery.of(context).padding;
  double safeAreaHeight = MediaQuery.of(context).size.height -
      safeAreaPadding.top -
      safeAreaPadding.bottom;
  return safeAreaHeight;
}

Future<void> opentUrl(String url, {LaunchMode? mode}) async {
  final Uri parseUrl = Uri.parse(url);
  LaunchMode _mode = LaunchMode.externalApplication;
  if (mode != null) _mode = mode;
  if (await canLaunchUrl(parseUrl)) {
    await launchUrl(parseUrl, mode: _mode);
  } else {
    throw Exception('Could not launch $parseUrl');
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    CustomSnackBar(message: message),
  );
}
