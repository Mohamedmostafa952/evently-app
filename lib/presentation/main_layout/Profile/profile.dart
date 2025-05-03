import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_drop_down_menu.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor,
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
                        SizedBox(height: 10.h),
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
                title: AppLocalizations.of(context)!.language,
                textView: configProvider.isEnglish ? "English" : "عربي",
                menuItems: ["English", "عربي"],
                onChange: onLangChange,
              ),
              SizedBox(height: 16.h),
              CustomDropDownMenu(
                title: AppLocalizations.of(context)!.theme,
                textView: configProvider.isDark ? AppLocalizations.of(context)!
                    .dark : AppLocalizations.of(context)!.light,
                menuItems: [
                  AppLocalizations.of(context)!.light,
                  AppLocalizations.of(context)!.dark
                ],
                onChange: onThemeChange,
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: REdgeInsets.symmetric(vertical: 28, horizontal: 16),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)
                )
            ),
            child: Padding(
              padding: REdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.logout_outlined),
                  SizedBox(width: 8),
                  Text(AppLocalizations.of(context)!.logout, style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onThemeChange(String? newTheme) {
    ThemeMode theme = newTheme == AppLocalizations.of(context)!.light
        ? ThemeMode.light
        : ThemeMode.dark;
    configProvider.changeAppTheme(theme);
  }

  void onLangChange(String? newLang) {
    String lang = newLang == "English" ? "en" : "ar";
    configProvider.changeAppLang(lang);
  }
}
