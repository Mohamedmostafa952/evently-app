import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 24),
            height: 1,
            color: ColorsManager.blue,
          ),
        ),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: ColorsManager.blue),
        ),
        Expanded(
          child: Container(
            margin: REdgeInsets.symmetric(horizontal: 24),
            height: 1,
            color: ColorsManager.blue,
          ),
        ),
      ],
    );
  }
}
