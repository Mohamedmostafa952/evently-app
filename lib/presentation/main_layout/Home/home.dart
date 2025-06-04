import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_event.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoryDM selectedCategory = ConstantsManager.categories[0];
  late ConfigProvider configProvider;


  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
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
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome_back,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                          Text(
                            UserDm.currentUser!.name,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge,
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
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            configProvider.isDark ? Icons.dark_mode : Icons
                                .wb_sunny_outlined,
                            color: ColorsManager.white,
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: REdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: ColorsManager.white,
                                borderRadius: BorderRadius.circular(14)
                            ),
                            child: Text(configProvider.isEnglish ? "En" : "ar",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  CustomTabBar(
                    onCategoryTabClicked: (category) {
                      selectedCategory = category;
                      setState(() {});
                    },
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
        StreamBuilder(
          stream: FirebaseServices.getEventsRealtimeUpdates(selectedCategory),
          // returns data based category id, ex if its 2 then it will return data with id=2
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              print("error");
            }

            List<EventDm> events = snapshot.data ?? [];
            return Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder:
                    (context, index) =>
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesManager.eventDetails,
                                arguments: events[index]);
                          },
                          child: CustomEvent(
                            event: events[index],
                            favEvent: UserDm.currentUser!.favEventsIds.contains(
                              events[index].id,
                            ),
                      ),
                    ),
              ),
            );
          },
        ),
      ],
    );
  }

// void loadData() async{
//   events = await FirebaseServices.getEventOneTimeRead();
//   setState(() {
//
//   });
// }
}
