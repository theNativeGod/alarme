import 'package:alarme/screens/clock_view.dart';
import 'package:flutter/material.dart';

class HomeScrenn extends StatelessWidget {
  const HomeScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ClockView(),
      ),
    );
  }
}
