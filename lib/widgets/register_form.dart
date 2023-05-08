import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/screens/login_screen.dart';
import 'package:login_firebase/ui/form_input_decorations.dart';
import 'package:login_firebase/widgets/text_widget.dart';
import '../services/utils.dart';
import '../ui/constants.dart';
import 'button_widget.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //* username is for decoration is not save in firebase.
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
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
            label: "Full name",
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _usernameController,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: "First name & Last name",
              prefixIcon: const Icon(
                Icons.person,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Full name is required';
              }
              final nameExp = RegExp(r'^[a-zA-Z]+ [a-zA-Z]+$');
              if (!nameExp.hasMatch(value)) {
                return 'Please enter a valid full name';
              }
              return null;
            },
          ),
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
            style: const TextStyle(color: Colors.white, fontSize: 13),
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
              hintText: "* * * * * * * *",
              prefixIcon: const Icon(
                Icons.lock,
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password is required';
              } else if (value.length <= 7) {
                return 'Your password must be at least 8 characters ';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            onPressed: _validateAndSubmit,
            label: 'Sign up',
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  void _validateAndSubmit() async {
    String error = "";
    if (_formKey.currentState!.validate()) {
      try {
        FocusScope.of(context).unfocus();
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => {
                  Utils.pushReplacementnoanimation(
                      context: context, newScreen: const LoginScreen()),
                  Utils.showSnackbar(
                      context: context,
                      backgroundColor: companyColor,
                      text: 'Your account was created successfully'),
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          error = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          error = 'The account already exists for that email.';
        }
        Utils.showSnackbar(context: context, text: error);
      } catch (e) {
        error = e.toString();
        Utils.showSnackbar(context: context, text: error);
      }
    }
  }
}
