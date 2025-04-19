import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_outlined_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/presentation/authentication/widgets/custom_divder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: Image.asset(ImageAssets.eventlyLogo)),
          SizedBox(height: 24.h,),
          Expanded(
            flex: 4,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    labelText: "Email",
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    labelText: "Password",
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    isObscure: obscure,
                    suffixIcon:
                    obscure ? Icons.visibility_off : Icons.visibility,
                    onClick: onClick,
                  ),
                  CustomTextButton(text: "Forget Password?", onPress: () {},),
                  CustomElevatedButton(text: "Login", onPress: () {}),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t Have Account ? ",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      CustomTextButton(text: "Create Account", onPress: () {}),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomDivider(text: "Or"),
                  SizedBox(height: 32.h),
                  CustomOutlinedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(SvgAssets.google),
                        SizedBox(width: 6.w),
                        Text(
                          "Login With Google",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ],
                    ),
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onClick() {
    setState(() {
      obscure = !obscure;
    });
  }
}
