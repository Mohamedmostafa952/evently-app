import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPress,
    this.alignment = Alignment.centerRight,
  });

  final String text;
  final VoidCallback onPress;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(
        context,
      ).textButtonTheme.style!.copyWith(alignment: alignment),
      onPressed: onPress,
      child: Text(text),
    );
  }
}
