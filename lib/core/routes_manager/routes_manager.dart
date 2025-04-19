import 'package:evently_app/presentation/authentication/signin/signin.dart';
import 'package:evently_app/presentation/authentication/signup/signup.dart';
import 'package:evently_app/presentation/main_layout/main_layout.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUP = "/signUp";
  static const String mainLayout = "/mainLayout";

  static Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (_) => SignIn());
      case signUP:
        return CupertinoPageRoute(builder: (_) => SignUp());
      case mainLayout:
        return CupertinoPageRoute(builder: (_) => MainLayout());
    }
  }
}
