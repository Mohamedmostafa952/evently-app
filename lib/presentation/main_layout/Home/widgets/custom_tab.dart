import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required this.category,
    required this.isSelected,
  });

  final CategoryDM category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46.r),
        color: isSelected ? ColorsManager.light : ColorsManager.blue,
        border: Border.all(color: ColorsManager.white, width: 1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            category.iconPath,
            colorFilter: ColorFilter.mode(
              isSelected ? ColorsManager.blue : ColorsManager.white,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            category.categoryName,
            style: GoogleFonts.inter(
              color: isSelected ? ColorsManager.blue : ColorsManager.white,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
