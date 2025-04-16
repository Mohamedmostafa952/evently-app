import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.child,
    required this.onPress,
  });

  final Widget child;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPress, child: child);
  }
}
