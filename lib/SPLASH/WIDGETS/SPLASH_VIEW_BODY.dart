import 'package:flutter/material.dart';

import 'package:weather_forecast_app/Weather_Screen.dart';

class SPLASH_VIEW_BODY extends StatefulWidget {
  const SPLASH_VIEW_BODY({super.key});

  @override
  State<SPLASH_VIEW_BODY> createState() => _SPLASH_VIEW_BODYState();
}

class _SPLASH_VIEW_BODYState extends State<SPLASH_VIEW_BODY>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? Fading_Animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    Fading_Animation =
        Tween<double>(begin: 0.1, end: 1).animate(animationController!);

    animationController!.repeat(reverse: true);

    navigate_to_next_page();
  }

  navigate_to_next_page() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Weather_Screen()));
      },
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        AnimatedBuilder(
          animation: Fading_Animation!,
          builder: (context, child) => Opacity(
            opacity: Fading_Animation!.value,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.14,
                  ),
                  const Text(
                    'Weather',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const Text(
                    'Forecast',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Weather_Screen()));
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.blue,
                        ),
                        Text('Go To Home Page'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                      width: size.width * 0.85,
                      height: size.height * 0.4,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Image.asset('assets/clouds-2085112_960_720.jpg')),
                  SizedBox(
                    height: size.height * 0.14,
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
