import 'package:flutter/material.dart';
import 'package:movies/pages/tabbar.dart';

class StartView extends StatelessWidget {
  const StartView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Movi',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'e+',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Image.asset(
                  'assets/images/start.jfif',
                  color: Colors.grey.withOpacity(0.9),
                  colorBlendMode: BlendMode.modulate,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Watch your favourite movies on only one platform. You can watch it anytime and anywhere ',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0F4C75),
                minimumSize: const Size(300, 70),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
