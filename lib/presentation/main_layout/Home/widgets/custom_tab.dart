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
    required this.selectedTabBg,
    required this.unselectedTabBg,
    required this.selectedLabelBg,
    required this.unselectedLabelBg,
  });

  final CategoryDM category;
  final bool isSelected;
  final Color selectedTabBg;
  final Color unselectedTabBg;
  final Color selectedLabelBg;
  final Color unselectedLabelBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46.r),
        color: isSelected ? selectedTabBg : unselectedTabBg,
        border: Border.all(color: selectedTabBg, width: 1),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            category.iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(
              isSelected ? selectedLabelBg : unselectedLabelBg,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            category.categoryName,
            style: GoogleFonts.inter(
              color: isSelected ? selectedLabelBg : unselectedLabelBg,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
