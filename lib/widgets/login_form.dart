import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/main_screen.dart';
import 'package:login_firebase/screens/forgot_password_screen.dart';
import 'package:login_firebase/widgets/text_widget.dart';
import '../services/utils.dart';
import '../ui/constants.dart';
import '../ui/form_input_decorations.dart';
import 'button_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              label: "Email address",
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: "example@domain.com",
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
              height: 10,
            ),
            const TextWidget(
              label: "Password",
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecorations.authInputDecoration(
                hintText: "********",
                prefixIcon: const Icon(
                  Icons.lock,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                } else if (value.length <= 7) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            TextButton(
              onPressed: () {
                Utils.pushReplacementnoanimation(
                    context: context, newScreen: const ResetPasswordScreen());
              },
              child: TextWidget(
                label: 'Forgot password?',
                color: companyColor,
              ),
            ),
            ButtonWidget(
              onPressed: _validateAndSubmit,
              label: 'Log in',
            ),
          ],
        ));
  }

  void _validateAndSubmit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                ));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          Utils.showSnackbar(
              text: 'Username or password is incorrect. Try again.',
              context: context);
        }
      } catch (e) {
        Utils.showSnackbar(text: e.toString(), context: context);
      }
    }
  }
}
