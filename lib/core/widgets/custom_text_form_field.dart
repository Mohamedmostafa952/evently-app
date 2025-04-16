import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    this.isObscure = false,
    this.suffixIcon,
    this.onClick,
  });

  final String labelText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final bool isObscure;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(onPressed: onClick, icon: Icon(suffixIcon)),
      ),
    );
  }
}
