import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/register_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/home_screens.dart';
import 'package:todo_app/screens/on_boarding_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/flash_screen',
      routes: {
        '/home_screen': (context) => HomeScreens(),
        '/on_boarding': (context) => OnBoardingScreen(),
        '/flash_screen': (context) => SplashScreen(),
        '/welcome_screen': (context) => WelcomeScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
      },
    );
  }
}
