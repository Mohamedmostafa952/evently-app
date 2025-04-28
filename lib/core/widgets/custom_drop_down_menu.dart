import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenu extends StatelessWidget {
  CustomDropDownMenu({
    super.key,
    required this.title,
    required this.textView,
    required this.menuItems,
    required this.onChange,
  });

  final String title;
  final String textView;
  final List<String> menuItems;
  void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1.w, color: ColorsManager.blue),
          ),
          child: Padding(
            padding: REdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textView,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                  child: DropdownButton<String>(
                    underline: Container(),
                    items:
                        menuItems.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: onChange,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
