import 'package:evently_app/core/extensions/string_extension.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  late TextEditingController emailController;
  late TextEditingController nameController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }
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
            child: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextFormField(
                          controller: nameController,
                          validator: (input) {
                            if (input == null || input
                                .trim()
                                .isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.name,
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          controller: emailController,
                          validator: (input) {
                            if (input == null || input
                                .trim()
                                .isEmpty) {
                              return "Please enter your email";
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
                            if (input == null || input
                                .trim()
                                .isEmpty) {
                              return "Please enter your password";
                            }
                            if (input.length < 6) {
                              return "password should be at least 6 characters";
                            }
                            return null;
                          },
                          labelText: AppLocalizations.of(context)!.password,
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          suffixIcon: passwordObscure
                              ? Icons.visibility_off
                              : Icons
                              .visibility,
                          isObscure: passwordObscure,
                          onClick: onPasswordClick,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextFormField(
                          controller: rePasswordController,
                          validator: (input) {
                            if (input == null || input
                                .trim()
                                .isEmpty) {
                              return "Please enter your password";
                            }
                            if (input != passwordController.text) {
                              return "password doesn't match";
                            }
                            return null;
                          },
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
                            onPress: _signUp),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .already_have_account,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,),
                            CustomTextButton(
                              text: AppLocalizations.of(context)!.login,
                              onPress: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesManager.signIn);
                              },
                              alignment: Alignment.center,)
                          ],
                        ),
                      ],
                    ),
                  ),
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

  void _signUp() async {
    try {
      if (!formKey.currentState!.validate()) return;
      DialogUtils.showLoadingDialog("Loading...", context);
      await FirebaseServices.register(email: emailController.text,
          password: passwordController.text,
          name: nameController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, message: "Registered successfully",
          posActionTitle: "ok",
          posAction: () {
            Navigator.pushReplacementNamed(context, RoutesManager.signIn);
          }
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(
            context, message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(
            context, message: 'The account already exists for that email.',
            posActionTitle: "Try Again");
      }
    } catch (e) {
      DialogUtils.showMessageDialog(
          context, message: e.toString(), title: "Error");
    }
  }
}

//Ahmed123