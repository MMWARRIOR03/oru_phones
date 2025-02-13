import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/otp_screen.dart';
import 'Screens/post-otp_screen.dart';
import 'Screens/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  await Future.delayed(const Duration(milliseconds: 300));
  // FlutterNativeSplash.remove();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/name': (context) => ConfirmNameScreen(),
      },
    );
  }
}
