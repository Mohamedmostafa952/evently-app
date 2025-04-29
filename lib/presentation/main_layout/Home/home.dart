import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/core/widgets/custom_event.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcome_back,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Mohamed Mostafa",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorsManager.white,
                      ),
                      Text(
                        " Cairo, Egypt",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomTabBar(
                    categories: ConstantsManager.categories,
                    selectedLabelBg: ColorsManager.blue,
                    selectedTabBg: ColorsManager.light,
                    unselectedLabelBg: ColorsManager.light,
                    unselectedTabBg: ColorsManager.blue,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder:
                (context, index) => CustomEvent(
                  event: EventDm(
                    category: "Birthday",
                    title: "Meeting for Updating The Development Method ",
                    description: "Meeting for Updating The Development Method ",
                    date: DateTime.now(),
                    time: TimeOfDay.now(),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
