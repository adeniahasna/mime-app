import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;
  const EmailTextField({super.key, required this.controller});

  @override
  createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends NyState<EmailTextField> {
  late FocusNode _emailFocusNode = FocusNode();
  bool isEmailFocused = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _emailFocusNode.addListener(() {
      setState(() {
        isEmailFocused = _emailFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget view(BuildContext context) {
    return NyTextField.emailAddress(
      controller: widget.controller,
      focusNode: _emailFocusNode,
      prefixIcon: Icon(Icons.email, color: Color(0xFF6D6D6D)),
      backgroundColor:
          isEmailFocused ? const Color(0xFFF8F5FF) : const Color(0xFFECECEC),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      style: TextStyle(fontSize: 15, color: Color(0xFF6D6D6D)),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: const Color(0xFF8F72E4), width: 2),
      ),
      validationRules: "not_empty",
    );
  }
}
