import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignUpButton extends StatefulWidget {
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  const SignUpButton(
      {super.key,
      required this.controllerEmail,
      required this.controllerPassword});

  @override
  createState() => _SignUpButtonState();
}

class _SignUpButtonState extends NyState<SignUpButton> {
  bool isValid = false;

  @override
  void initState() {
    super.initState();

    widget.controllerEmail.addListener(updateButtonState);
    widget.controllerPassword.addListener(updateButtonState);
  }

  @override
  void dispose() {
    widget.controllerEmail.removeListener(updateButtonState);
    widget.controllerPassword.removeListener(updateButtonState);

    super.dispose();
  }

  void updateButtonState() {
    setState(() {
      isValid = widget.controllerEmail.text.isNotEmpty &&
          widget.controllerPassword.text.isNotEmpty;
    });
  }

  @override
  Widget view(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        NyLogger.info("Sign in button pressed !");
      },
      color: isValid ? Color(0xFF4413D2) : Color(0xFFD1C8FF),
      textColor: Colors.white,
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 135),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "Sign Up",
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.anekDevanagari().fontFamily),
      ),
    );
  }
}
