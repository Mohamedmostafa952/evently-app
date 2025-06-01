import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.isObscure = false,
    this.suffixIcon,
    this.onClick,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.controller, this.validator
  });

  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isObscure;
  final VoidCallback? onClick;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      obscureText: isObscure,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: IconButton(onPressed: onClick, icon: Icon(suffixIcon)),
      ),
    );
  }
}
