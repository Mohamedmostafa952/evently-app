import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordObscure = true;
  bool rePasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register)),
      body: Column(
        children: [
          Expanded(flex: 1, child: Image.asset(ImageAssets.eventlyLogo)),
          SizedBox(height: 24.h),
          Expanded(
            flex: 4,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      labelText: AppLocalizations.of(context)!.name,
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      labelText: AppLocalizations.of(context)!.email,
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      labelText: AppLocalizations.of(context)!.password,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icons.lock,
                      suffixIcon: passwordObscure ? Icons.visibility_off : Icons
                          .visibility,
                      isObscure: passwordObscure,
                      onClick: onPasswordClick,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      labelText: AppLocalizations.of(context)!.re_password,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Icons.lock,
                      suffixIcon: rePasswordObscure
                          ? Icons.visibility_off
                          : Icons
                          .visibility,
                      isObscure: rePasswordObscure,
                      onClick: onRePasswordClick,
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                        text: AppLocalizations.of(context)!.signup,
                        onPress: () {}),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.already_have_account,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodySmall,),
                        CustomTextButton(
                          text: AppLocalizations.of(context)!.login,
                          onPress: () {},
                          alignment: Alignment.center,)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPasswordClick() {
    passwordObscure = !passwordObscure;
    setState(() {

    });
  }

  void onRePasswordClick() {
    rePasswordObscure = !rePasswordObscure;
    setState(() {

    });
  }
}
