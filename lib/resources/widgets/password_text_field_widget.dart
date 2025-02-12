import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({super.key, required this.controller});

  @override
  createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends NyState<PasswordTextField> {
  late FocusNode _passFocusNode = FocusNode();
  bool isPasswordVisible = false;
  bool isPassFocused = false;

  @override
  void initState() {
    super.initState();
    _passFocusNode = FocusNode();
    _passFocusNode.addListener(() {
      setState(() {
        isPassFocused = _passFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget view(BuildContext context) {
    return NyTextField.password(
      controller: widget.controller,
      obscureText: !isPasswordVisible,
      focusNode: _passFocusNode,
      prefixIcon: Icon(Icons.lock, color: Color(0xFF6D6D6D)),
      backgroundColor:
          isPassFocused ? const Color(0xFFF8F5FF) : const Color(0xFFECECEC),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: const Color(0xFF8F72E4), width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      style: TextStyle(
        fontSize: 15,
        color: Color(0xFF6D6D6D),
      ),
      validationRules: "not_empty",
    );
  }
}
