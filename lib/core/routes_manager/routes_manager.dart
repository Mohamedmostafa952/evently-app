import 'package:evently_app/presentation/authentication/signin/signin.dart';
import 'package:evently_app/presentation/authentication/signup/signup.dart';
import 'package:evently_app/presentation/create_event/create_event.dart';
import 'package:evently_app/presentation/create_event/selected_location.dart';
import 'package:evently_app/presentation/main_layout/main_layout.dart';
import 'package:evently_app/presentation/onboarding/onboarding.dart';
import 'package:evently_app/presentation/onboarding/starting_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUP = "/signUp";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/CreateEvent";
  static const String selectedLocation = "/selectedLocation";
  static const String startingScreen = "/startingScreen";
  static const String onboarding = "/onboarding";

  static Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (_) => SignIn());
      case signUP:
        return CupertinoPageRoute(builder: (_) => SignUp());
      case mainLayout:
        return CupertinoPageRoute(builder: (_) => MainLayout());
      case createEvent:
        return CupertinoPageRoute(builder: (_) => CreateEvent());
      case selectedLocation:
        return CupertinoPageRoute(builder: (_) => SelectedLocation());
      case startingScreen:
        return CupertinoPageRoute(builder: (_) => StartingScreen());
      case onboarding:
        return CupertinoPageRoute(builder: (_) => Onboarding());
    }
  }
}
