import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/firebase_options.dart';
import 'package:qr_code/modules/scan_screen.dart/scan_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'QR Code App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ).copyWith(primaryColor: Colors.blue),
        home: const ScanScreen());
  }
}
