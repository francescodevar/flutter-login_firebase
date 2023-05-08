import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/screens/login_screen.dart';
import 'package:login_firebase/screens/veryfy_email_screen.dart';
import 'package:login_firebase/ui/constants.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: companyColor),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.hasData) {
              return const VerifyEmailScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
