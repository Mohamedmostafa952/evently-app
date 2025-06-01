import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  Widget _buildImage(String imagePath) {
    return Image.asset(imagePath);
  }

  void _onDone(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("firstTime", false);
    Navigator.pushNamed(context, RoutesManager.signIn);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = Theme.of(context).textTheme.bodySmall!;
    PageDecoration pageDecoration = PageDecoration(
      imageAlignment: Alignment.center,
      titleTextStyle: Theme.of(context).textTheme.labelMedium!,
      bodyTextStyle: bodyStyle,
      imageFlex: 2,
      imagePadding: EdgeInsets.only(top: 115, left: 16, right: 16),
    );

    return IntroductionScreen(
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      allowImplicitScrolling: true,
      infiniteAutoScroll: false,
      globalHeader: Image.asset(ImageAssets.onboardingLogo),
      pages: [
        PageViewModel(
          title: "Find Events That Inspire You",
          body:
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          image: _buildImage(ImageAssets.onboarding2),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Effortless Event Planning",
          body:
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
          image: _buildImage(ImageAssets.onboarding3),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Connect with Friends & Share Moments",
          body:
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
          image: _buildImage(ImageAssets.onboarding4),
          decoration: pageDecoration,
        ),
      ],
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: Container(
        padding: REdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.blue, width: 1.w),
        ),
        child: Icon(Icons.arrow_back, color: ColorsManager.blue),
      ),
      next: Container(
        padding: REdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.blue, width: 1.w),
        ),
        child: Icon(Icons.arrow_forward, color: ColorsManager.blue),
      ),
      done: Container(
        padding: REdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.blue, width: 1.w),
        ),
        child: Icon(Icons.arrow_forward, color: ColorsManager.blue),
      ),
      onDone: () {
        _onDone(context);
      },
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: ColorsManager.black,
        activeColor: ColorsManager.blue,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
