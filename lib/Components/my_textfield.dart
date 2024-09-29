import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final Icon iconum;

  const MyTextField(
      {
        super.key,
        required this.controller,
        required this.hintText,
        required this.obscureText,
        this.focusNode,
        required this.iconum
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: iconum,
            hintText: hintText
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Icon iconum;

  PasswordField({required this.hintText, required this.controller, required this.iconum});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.iconum,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),

        ),
      ),
    );
  }
}

