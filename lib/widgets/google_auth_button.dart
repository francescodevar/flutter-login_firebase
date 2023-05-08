import 'package:flutter/material.dart';
import 'package:login_firebase/services/auth_services.dart';
import '../main_screen.dart';
import 'text_widget.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[600],
              ),
            ),
            Text(
              " Or ",
              style: TextStyle(color: Colors.grey[600]),
            ),
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
              onPressed: () {
                AuthService().signInWithGoogle();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              icon: Image.asset(
                'assets/google.png',
                width: 20,
                height: 20,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: TextWidget(
                  label: 'Continue with Google',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )),
        ),
      ],
    );
  }
}
