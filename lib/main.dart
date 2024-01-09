import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/color_palette.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Supabase.initialize(
      url: 'https://dqphyikdrdzkmwxsgukq.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRxcGh5aWtkcmR6a213eHNndWtxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDc3MzcwMCwiZXhwIjoyMDIwMzQ5NzAwfQ.5AX3S8h2r8TOH8Gezh9P6mJ86_Y88kNwwbAVgV-ds44');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
