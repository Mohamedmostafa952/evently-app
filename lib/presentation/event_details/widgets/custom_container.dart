import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.icon,
    required this.secondPart,
  });

  final IconData icon;
  final Widget secondPart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.blue, width: 1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: REdgeInsets.all(8),
            child: Icon(icon, color: ColorsManager.white),
          ),
          SizedBox(width: 8.w),
          Expanded(child: secondPart),
        ],
      ),
    );
  }
}
