import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
      useMaterial3: false,
      primaryColor: ColorsManager.blue,
      appBarTheme: AppBarTheme(
          backgroundColor: ColorsManager.light,
          centerTitle: true,
          titleTextStyle: GoogleFonts.roboto(
              fontSize: 22,
              color: ColorsManager.black
          )
      ),
      scaffoldBackgroundColor: ColorsManager.light,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: ColorsManager.grey,
        suffixIconColor: ColorsManager.grey,
        labelStyle: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.w, color: ColorsManager.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.w, color: ColorsManager.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.w, color: ColorsManager.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(width: 1.w, color: ColorsManager.red),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: ColorsManager.blue,
          textStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          backgroundColor: ColorsManager.blue,
          foregroundColor: ColorsManager.white,
          textStyle: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.blue,
          side: BorderSide(
            color: ColorsManager.blue,
            style: BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
        ),
      ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          color: ColorsManager.black,
        ),
        titleMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
          color: ColorsManager.blue,
        ),
        titleLarge: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white
        ),
        titleSmall: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.white,
          unselectedItemColor: ColorsManager.white,
          elevation: 0
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: ColorsManager.blue,
        shape: CircularNotchedRectangle(),
      ),
      iconTheme: IconThemeData(
          color: ColorsManager.white
      )
  );
  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorsManager.dark,
  );
}
