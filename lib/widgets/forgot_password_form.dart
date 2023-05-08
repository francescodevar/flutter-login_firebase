import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/utils.dart';
import '../screens/login_screen.dart';
import '../ui/constants.dart';
import '../ui/form_input_decorations.dart';
import 'button_widget.dart';
import 'text_widget.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const TextWidget(
              label: "Email address",
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white, fontSize: 13,),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: "example@email.com",
                prefixIcon: const Icon(
                  Icons.email_rounded,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
              onPressed: _validateAndSubmit,
              label: 'Send',
            ),
            const SizedBox(
              height: 10,
            ),
            
          ],
        ));
  }

  void _validateAndSubmit() async {
    String error = "";
    if (_formKey.currentState?.validate() ?? true) {
      try {
        FocusScope.of(context).unfocus();
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text)
            .then((value) => {
                  Utils.pushReplacementnoanimation(
                      context: context, newScreen: const LoginScreen()),
                  Utils.showSnackbar(
                      context: context,
                      backgroundColor: companyColor,
                      text: 'Password reset email sent successfully'),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          error = 'No user found with that email address.';
          Utils.showSnackbar(context: context, text: error);
        } else {
          error =
              'An error occurred while sending the password reset email. Please try again later.';
          Utils.showSnackbar(context: context, text: error);
        }
      }
    }
  }
}
