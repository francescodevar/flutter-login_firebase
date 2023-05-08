import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/main_screen.dart';
import 'package:login_firebase/ui/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
            useMaterial3: true, scaffoldBackgroundColor: backgroundColor),
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        home: const MainScreen());
  }
}
