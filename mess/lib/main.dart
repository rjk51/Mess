import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:mess/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    home: const Splash(),
  ));
}
