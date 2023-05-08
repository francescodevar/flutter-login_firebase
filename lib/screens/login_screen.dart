import 'package:flutter/material.dart';
import 'package:login_firebase/screens/register_screen.dart';
import 'package:login_firebase/widgets/login_form.dart';

import '../services/utils.dart';
import '../ui/constants.dart';
import '../widgets/google_auth_button.dart';
import '../widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/submarine.png",
                        height: 75,
                        width: 75,
                      ),
                      TextWidget(
                        label: 'Data Submarine ',
                        fontSize: 20,
                        color: companyColor,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const LoginForm(),
                      const GoogleAuth(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            label: 'Don\'t have an account?',
                          ),
                          TextButton(
                            onPressed: () {
                              Utils.pushReplacementnoanimation(
                                  context: context,
                                  newScreen: const RegisterScreen());
                            },
                            child: Align(
                              child: TextWidget(
                                label: 'Sign up ',
                                color: companyColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
