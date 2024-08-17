// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:movies/pages/start.dart';

class splash_scraen extends StatefulWidget {
  const splash_scraen({super.key});

  @override
  State<splash_scraen> createState() => _splash_scraenState();
}

class _splash_scraenState extends State<splash_scraen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _wordAnimation1;
  late Animation<Offset> _wordAnimation2;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _wordAnimation1 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _wordAnimation2 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _lineAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const StartView(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _wordAnimation1,
                  child: const Text(
                    'MOVIES',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SlideTransition(
                  position: _wordAnimation2,
                  child: const Text(
                    'TIME',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _lineAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0.0, (1 - _lineAnimation.value) * 100),
                  child: Opacity(
                    opacity: _lineAnimation.value,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: 150,
                      height: 4,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
