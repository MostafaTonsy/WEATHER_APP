import 'package:flutter/material.dart';

class card_wf_widget extends StatelessWidget {
  final IconData Icon2;
  final String time2;
  final String temp2;
  const card_wf_widget(
      {super.key,
      required this.Icon2,
      required this.time2,
      required this.temp2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: Card(
        color: const Color.fromARGB(255, 97, 0, 0),
        surfaceTintColor: const Color.fromARGB(255, 97, 0, 0),
        elevation: 15,
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                time2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Icon(
                Icon2,
                size: 32,
                color: Colors.white,
              ),
              const SizedBox(height: 2),
              Text(
                temp2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
