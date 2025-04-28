import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_drop_down_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String selectedLang = "English";
  String selectedTheme = "Light";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: ColorsManager.blue,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(28.r)),
          ),
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset(ImageAssets.profilePic),
                  SizedBox(width: 16.w),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mohamed Mostafa",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          "mohamedmostafa@email.com",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              CustomDropDownMenu(
                title: "Language",
                textView: selectedLang,
                menuItems: ["English", "عربي"],
                onChange: onLangChange,),
              SizedBox(height: 16.h,),
              CustomDropDownMenu(title: "Theme",
                textView: selectedTheme,
                menuItems: ["Light", "Dark"],
                onChange: onThemeChange,),
            ],
          ),
        ),
      ],
    );
  }

  void onThemeChange(String? newTheme) {
    selectedTheme = newTheme!;
    setState(() {

    });
  }

  void onLangChange(String? newLang) {
    selectedLang = newLang!;
    setState(() {

    });
  }
}
