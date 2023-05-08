import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/screens/home_screen.dart';
import 'package:login_firebase/services/utils.dart';

import '../ui/constants.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackbar(context: context, text: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomeScreen()
      : Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/email.json'),
                  TextWidget(
                    label: "Verify your email",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: companyColor,
                  ),
                  TextWidget(
                    textAlign: TextAlign.center,
                    label:
                        'An email has been sent to ${user.email} with a link to verify your account. If you have not received the email after a few minutes, please check your spam folder.',
                    fontSize: 13,
                  ),
                  TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: TextWidget(
                      label: 'Back to Log in page',
                      color: companyColor,
                    ),
                  ),
                  ButtonWidget(
                    onPressed: canResendEmail
                        ? () {
                            sendVerificationEmail();
                            Utils.showSnackbar(
                                context: context,
                                text: "Email was sent successfully",
                                backgroundColor: companyColor);
                          }
                        : () {
                            Utils.showSnackbar(
                                context: context,
                                text:
                                    "to many request, wait a moment and try again");
                          },
                    label: 'Resend email verification',
                  ),
                ],
              ),
            ),
          ),
        );
}
