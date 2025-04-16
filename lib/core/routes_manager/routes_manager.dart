import 'package:evently_app/presentation/authentication/signin/signin.dart';
import 'package:evently_app/presentation/authentication/signup/signup.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static const String signIn = "/signIn";
  static const String signUP = "/signUp";

  static Route? routes(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return CupertinoPageRoute(builder: (_) => SignIn());
      case signUP:
        return CupertinoPageRoute(builder: (_) => SignUp());
    }
  }
}
