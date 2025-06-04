import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImageAssets.resetPassword),
              SizedBox(height: 24.h),
              CustomTextFormField(
                controller: emailController,
                labelText: "enter your email",
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                text: "Reset Password",
                onPress: () async {
                  await FirebaseServices.resetPassword(
                    emailController.text,
                  ).then((value) {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesManager.signIn,
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
