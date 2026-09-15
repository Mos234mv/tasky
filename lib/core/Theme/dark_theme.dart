import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    titleTextStyle: TextStyle(fontSize: 20.sp, color: Color(0xFFFFFCFC)),
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
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(fontSize: 32.sp, color: Color(0xFFFFFCFC)),
    // for Done task
    titleLarge: TextStyle(
      color: Color(0xFFA0A0A0),
      fontSize: 16.sp,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFFA0A0A0),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16.sp),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(198, 198, 198, 1),
      fontSize: 14.sp,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      fontSize: 16.sp,
    ),
    labelSmall: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xFF6D6D6D)),
    filled: true,
    fillColor: const Color(0xFF282828),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 0.5.w),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2.w),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC), size: 26),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none,
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E), thickness: 1),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
      fontSize: 16.sp,
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 10,
    textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
  ),
);
