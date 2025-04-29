import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatelessWidget {
  const CreateEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.create_event)),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(ImageAssets.birthday),
              ),
              CustomTabBar(
                categories: ConstantsManager.categoriesWithoutAll,
                selectedLabelBg: ColorsManager.light,
                selectedTabBg: ColorsManager.blue,
                unselectedLabelBg: ColorsManager.blue,
                unselectedTabBg: ColorsManager.light,
                verticalPadding: 16,
              ),
              Text(AppLocalizations.of(context)!.title, style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall),
              SizedBox(height: 8.h),
              CustomTextFormField(
                labelText: AppLocalizations.of(context)!.event_title,
                prefixIcon: Icons.edit_note_outlined,
              ),
              SizedBox(height: 16.h),
              Text(AppLocalizations.of(context)!.description, style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall),
              SizedBox(height: 8.h),
              CustomTextFormField(
                  labelText: AppLocalizations.of(context)!.event_description,
                  maxLines: 3),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.event_date,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ),
                  CustomTextButton(
                      text: AppLocalizations.of(context)!.choose_date,
                      onPress: () {}),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.event_time,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                  ),
                  CustomTextButton(
                      text: AppLocalizations.of(context)!.choose_time,
                      onPress: () {}),
                ],
              ),
              SizedBox(height: 16.h),
              CustomElevatedButton(
                  text: AppLocalizations.of(context)!.add_event,
                  onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
