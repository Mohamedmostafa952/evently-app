import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/presentation/authentication/reset_password/reset_password.dart';
import 'package:evently_app/presentation/authentication/signin/signin.dart';
import 'package:evently_app/presentation/authentication/signup/signup.dart';
import 'package:evently_app/presentation/create_event/create_event.dart';
import 'package:evently_app/presentation/create_event/selected_location.dart';
import 'package:evently_app/presentation/event_details/event_details_view.dart';
import 'package:evently_app/presentation/main_layout/main_layout.dart';
import 'package:evently_app/presentation/onboarding/onboarding.dart';
import 'package:evently_app/presentation/onboarding/starting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUP = "/signUp";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/CreateEvent";
  static const String selectedLocation = "/selectedLocation";
  static const String startingScreen = "/startingScreen";
  static const String onboarding = "/onboarding";
  static const String eventDetails = "/eventDetails";
  static const String resetPassword = "/resetPassword";

  static Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (_) => SignIn());
      case signUP:
        return CupertinoPageRoute(builder: (_) => SignUp());
      case mainLayout:
        return CupertinoPageRoute(builder: (_) => MainLayout());
      case createEvent:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => CreateEvent(event: settings.arguments as EventDm?),
        );
      case selectedLocation:
        return CupertinoPageRoute(builder: (_) => SelectedLocation());
      case startingScreen:
        return CupertinoPageRoute(builder: (_) => StartingScreen());
      case onboarding:
        return CupertinoPageRoute(builder: (_) => Onboarding());
      case eventDetails:
        return CupertinoPageRoute(
          settings: settings,
          builder:
              (_) => EventDetailsView(event: settings.arguments as EventDm),
        );
      case resetPassword:
        return CupertinoPageRoute(builder: (_) => ResetPassword());
    }
    return null;
  }

  static Widget alreadyLogin() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return MainLayout();
        } else {
          return StartingScreen();
        }
      },
    );
  }
}
