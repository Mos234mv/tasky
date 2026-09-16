import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoprof/core/constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFC6C6C6),
    scrim: Color(0xFF15B86C),
    onSurface: Color(0xFFC6C6C6),
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      color: Color(0xFFFFFCFC),
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
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

      return Colors.transparent;
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
      color: Color(0xFFFFFFFF),
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(fontSize: AppSizes.sp32, color: Color(0xFFFFFCFC)),
    // for Done task
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: AppSizes.sp16,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: AppSizes.sp16),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(198, 198, 198, 1),
      fontSize: AppSizes.sp14,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp16,
    ),
    labelSmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: const Color(0xFF282828),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide.none,
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
    side: BorderSide(color: Color(0xFF6E6E6E), width: AppSizes.w2),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC), size: AppSizes.r26),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E), thickness: 1),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      fontSize: AppSizes.sp16,
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: Colors.red,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
    ),
    elevation: AppSizes.r10,
    textStyle: TextStyle(fontSize: AppSizes.sp20, fontWeight: FontWeight.w400),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
  ),
);
