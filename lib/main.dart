import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:rapyd_collect_api/core/app_theme.dart';
import 'package:rapyd_collect_api/src/view/screen/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      home: const HomeScreen(),
      theme: AppTheme.lightTheme,
    );
  }
}
