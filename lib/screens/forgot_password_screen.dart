import 'package:flutter/material.dart';
import '../services/utils.dart';
import '../widgets/forgot_password_form.dart';
import '../ui/constants.dart';
import '../widgets/text_widget.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    label: 'Forgot Your password?',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: companyColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextWidget(
                    label:
                        'Please enter your registered email below to receive password reset instructions.',
                    fontSize: 15,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const ResetPasswordForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        label: 'Remember password?',
                      ),
                      TextButton(
                        onPressed: () {
                          Utils.pushReplacementnoanimation(
                              context: context, newScreen: const LoginScreen());
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
    );
  }
}
