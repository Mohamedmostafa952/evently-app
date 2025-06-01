import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  bool switchLangValue = false;
  bool switchThemeValue = false;
  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(ImageAssets.onboardingLogo),
                Image.asset(ImageAssets.onboarding1),
                Padding(
                  padding: REdgeInsets.only(top: 28, bottom: 28),
                  child: Text(
                    "Personalize Your Experience",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(bottom: 28),
                  child: Text(
                    "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Language",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: switchLangValue,
                      onChanged: (value) {
                        switchLangValue = !switchLangValue;
                        if (switchLangValue) {
                          configProvider.changeAppLang("ar");
                        } else {
                          configProvider.changeAppLang("en");
                        }
                        setState(() {});
                      },
                      activeThumbImage: AssetImage(ImageAssets.arabic),
                      inactiveThumbImage: AssetImage(ImageAssets.english),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Theme",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: switchThemeValue,
                      onChanged: (value) {
                        switchThemeValue = !switchThemeValue;
                        if (switchThemeValue) {
                          configProvider.changeAppTheme(ThemeMode.dark);
                        } else {
                          configProvider.changeAppTheme(ThemeMode.light);
                        }
                        setState(() {});
                      },
                      activeThumbImage: AssetImage(ImageAssets.dark),
                      inactiveThumbImage: AssetImage(ImageAssets.light),
                      inactiveThumbColor: ColorsManager.blue,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  text: "Let's start",
                  onPress: () {
                    Navigator.pushNamed(context, RoutesManager.onboarding);
                  },
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
