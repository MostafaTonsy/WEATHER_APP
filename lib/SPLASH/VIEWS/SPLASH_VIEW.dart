import 'package:flutter/material.dart';

import 'package:weather_forecast_app/SPLASH/WIDGETS/SPLASH_VIEW_BODY.dart';

class SPLASH_VIEW extends StatelessWidget {
  const SPLASH_VIEW({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SPLASH_VIEW_BODY(),
    );
  }
}
