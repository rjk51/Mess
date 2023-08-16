import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

import 'package:mess/screens/selection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToSelection(context);
  }

  Future<void> _navigateToSelection(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));

    navigatorKey.currentState!.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const Selection(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var opacityAnimation = animation.drive(tween);

          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Center(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        "assets/images/logo.png",
      ),
      const SizedBox(height: 20),
      Text('"Mess"',
          style: GoogleFonts.bangers(
              textStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 110, 255),
            fontSize: 50,
          ))),
      const SizedBox(height: 120),
      Text('~by Ayaan Rajak',
          style: GoogleFonts.robotoCondensed(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ))
    ]),
  );
}
}
