import 'package:flutter/material.dart';
import 'package:login_firebase/ui/constants.dart';
import 'package:login_firebase/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const ButtonWidget({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10),
            backgroundColor: companyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: TextWidget(
            label: label,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
