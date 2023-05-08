import 'package:flutter/material.dart';
import '../services/utils.dart';
import '../ui/constants.dart';
import '../widgets/register_form.dart';
import '../widgets/text_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextWidget(
                      label: 'Create an account',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: companyColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const RegisterForm(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextWidget(
                          label: 'Have an account?',
                        ),
                        TextButton(
                          onPressed: () {
                            Utils.pushReplacementnoanimation(
                                context: context,
                                newScreen: const LoginScreen());
                          },
                          child: TextWidget(
                            label: 'Log in',
                            color: companyColor,
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
    );
  }
}
