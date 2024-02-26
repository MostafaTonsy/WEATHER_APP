import 'package:flutter/material.dart';
import 'package:weather_forecast_app/SPLASH/VIEWS/SPLASH_VIEW.dart';

void main() {
  runApp(const MyAndroidApp());
}

class MyAndroidApp extends StatelessWidget {
  const MyAndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const SPLASH_VIEW(),
    );
  }
}
