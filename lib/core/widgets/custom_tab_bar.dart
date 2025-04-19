import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/presentation/main_layout/Home/widgets/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.categories});

  final List<CategoryDM> categories;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        isScrollable: true,
        labelPadding: REdgeInsets.symmetric(horizontal: 8),
        onTap: (newTabIndex) {
          selectedIndex = newTabIndex;
          setState(() {});
        },
        indicatorColor: Colors.transparent,
        tabs:
            widget.categories
                .map(
                  (category) => CustomTab(
                    category: category,
                    isSelected:
                        widget.categories.indexOf(category) == selectedIndex,
                  ),
                )
                .toList(),
      ),
    );
  }
}
