import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF3A4640),
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      color: Color(0xFF161F1B),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
      }

      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      }

      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }

      return Color(0xFF9E9E9E);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xFF15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
      textStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: AppSizes.sp14, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(fontSize: AppSizes.sp32, color: Color(0xFf161F1B)),
    titleLarge: TextStyle(
      color: Color(0xFF6A6A6A),
      fontSize: AppSizes.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: AppSizes.sp16),

    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
      fontSize: AppSizes.sp14,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFf161F1B),
      fontSize: AppSizes.sp16,
    ),
    labelSmall: TextStyle(
      color: Color(0xFf161F1B),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xff9E9E9E)),
    filled: true,
    focusColor: Color(0xffD1DAD6),
    fillColor: const Color(0xFFFFFFFF),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Colors.red, width: 0.5.w),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(color: Color(0xFFD1DAD6), width: AppSizes.w2),
  ),
  iconTheme: IconThemeData(color: Color(0xFf161F1B), size: AppSizes.r26),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFf161F1B),
      fontSize: AppSizes.sp16,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.red,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    elevation: AppSizes.r10,
    textStyle: TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w400),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.black)),
  ),
);
