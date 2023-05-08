import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/widgets/button_widget.dart';
import 'package:login_firebase/widgets/text_widget.dart';

import '../ui/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Scaffold(
        body: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  label: "log in with",
                  fontSize: 16,
                  color: companyColor,
                ),
                TextWidget(label: user.email!),
                const SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                    onPressed: () {
                      _confettiController.play();
                    },
                    label: "Celebrate 🎉"),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: TextWidget(
                    label: 'Back to Log in page',
                    color: companyColor,
                  ),
                ),
                ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: -pi / 2,
                  emissionFrequency: 0.2,
                  numberOfParticles: 20,
                  blastDirectionality: BlastDirectionality.explosive,
                  gravity: 0.3,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

// Text(user.email!),
// ButtonWidget(
//     onPressed: () => FirebaseAuth.instance.signOut(),
//     label: "se hizo"),
