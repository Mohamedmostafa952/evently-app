import 'package:evently_app/config/theme/theme_manager.dart';
import 'package:evently_app/core/extensions/build_context_size.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(context.getScreenWidth, context.getScreenHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.light,
            darkTheme: ThemeManager.dark,
            themeMode: ThemeMode.light,
            onGenerateRoute: RoutesManager.routes,
            initialRoute: RoutesManager.mainLayout,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            // [
            //               AppLocalizations.delegate,
            //               GlobalMaterialLocalizations.delegate,
            //               GlobalWidgetsLocalizations.delegate,
            //               GlobalCupertinoLocalizations.delegate,
            //             ],
            supportedLocales: [
              Locale('en'), // English
              Locale('ar'), // Spanish
            ],
            locale: Locale("en"),
          ),
    );
  }
}
