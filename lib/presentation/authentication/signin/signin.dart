import 'package:evently_app/core/extensions/string_extension.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_outlined_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:evently_app/presentation/authentication/widgets/custom_divder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscure = true;

  late TextEditingController passwordController;

  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 1, child: Image.asset(ImageAssets.eventlyLogo)),
            SizedBox(height: 24.h),
            Expanded(
              flex: 4,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: emailController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return "please enter your email";
                          }
                          if (!input.isValidEmail) {
                            return "enter a valid email";
                          }
                          return null;
                        },
                        labelText: AppLocalizations.of(context)!.email,
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextFormField(
                        controller: passwordController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return "please enter your password";
                          }
                          if (input.length < 6) {
                            return "password should be at least 6 characters";
                          }
                          return null;
                        },
                        labelText: AppLocalizations.of(context)!.password,
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        isObscure: obscure,
                        suffixIcon:
                            obscure ? Icons.visibility_off : Icons.visibility,
                        onClick: onClick,
                      ),
                      CustomTextButton(
                        text: AppLocalizations.of(context)!.forget_password,
                        onPress: () {},
                      ),
                      CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login,
                        onPress: login,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_account,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(width: 4.w),
                          CustomTextButton(
                            text: AppLocalizations.of(context)!.create_account,
                            onPress: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.signUP,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CustomDivider(text: AppLocalizations.of(context)!.or),
                      SizedBox(height: 16.h),
                      CustomOutlinedButton(
                        child: Padding(
                          padding: REdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(SvgAssets.google),
                              SizedBox(width: 6.w),
                              Text(
                                AppLocalizations.of(context)!.login_with_google,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        onPress: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClick() {
    setState(() {
      obscure = !obscure;
    });
  }

  void login() async {
    try {
      if (!formKey.currentState!.validate()) return;
      DialogUtils.showLoadingDialog("Loading...", context);
      await FirebaseServices.login(
        emailController.text,
        passwordController.text,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: "Logged in successfully",
        posActionTitle: "ok",
        posAction: () {
          Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'invalid-credential') {
        DialogUtils.showMessageDialog(
          context,
          message: 'email or password is wrong.',
          posActionTitle: "Try Again",
        );
      }
    } catch (e) {
      DialogUtils.showMessageDialog(
        context,
        message: e.toString(),
        title: "Error",
      );
    }
  }
}
