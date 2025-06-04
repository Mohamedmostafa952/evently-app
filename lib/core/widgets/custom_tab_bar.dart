import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/presentation/main_layout/Home/widgets/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    required this.categories,
    required this.selectedTabBg,
    required this.unselectedTabBg,
    required this.selectedLabelBg,
    required this.unselectedLabelBg,
    this.verticalPadding = 0,
    required this.onCategoryTabClicked,
    this.initialIndex = 0,
  });

  final List<CategoryDM> categories;
  final Color selectedTabBg;
  final Color unselectedTabBg;
  final Color selectedLabelBg;
  final Color unselectedLabelBg;
  final double verticalPadding;
  final void Function(CategoryDM) onCategoryTabClicked;
  final int initialIndex;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length,
      child: TabBar(
        padding: REdgeInsets.symmetric(vertical: widget.verticalPadding),
        isScrollable: true,
        labelPadding: REdgeInsets.symmetric(horizontal: 8),
        onTap: (newTabIndex) {
          widget.onCategoryTabClicked(widget.categories[newTabIndex]);
          selectedIndex = newTabIndex;
          setState(() {});
        },
        indicatorColor: Colors.transparent,
        tabs:
            widget.categories
                .map(
                  (category) => CustomTab(
                    selectedLabelBg: widget.selectedLabelBg,
                    unselectedLabelBg: widget.unselectedLabelBg,
                    selectedTabBg: widget.selectedTabBg,
                    unselectedTabBg: widget.unselectedTabBg,
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
