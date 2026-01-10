import 'package:tasky/core/imports.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: LightColors.backGround,
  primaryColor: LightColors.primary,
  colorScheme: ColorScheme.dark(
    primaryContainer: LightColors.backGround2,
    secondaryContainer: Colors.grey.shade200,
    outline: LightColors.border,
    shadow: LightColors.text4,
    error: Colors.red.shade700,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: LightColors.backGround,
    titleTextStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: LightColors.text1,
      fontSize: 22,
    ),
    iconTheme: IconThemeData(color: LightColors.text1),
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  textTheme: TextTheme(
    displayMedium: GoogleFonts.plusJakartaSans(
      color: LightColors.text1,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: GoogleFonts.poppins(
      color: LightColors.text2,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.poppins(
      color: LightColors.text3,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.roboto(
      color: LightColors.text3,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      decoration: TextDecoration.none,
      decorationColor: LightColors.hashedText,
      decorationThickness: 2,
    ),
    //* for done task
    labelMedium: GoogleFonts.poppins(
      color: LightColors.hashedText,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: LightColors.hashedText,
      decorationThickness: 2,
    ),
    labelSmall: GoogleFonts.roboto(
      color: LightColors.hashedText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      decoration: TextDecoration.lineThrough,
      decorationColor: LightColors.hashedText,
      decorationThickness: 2,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LightColors.backGround2,
    hintStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: Color(0xff9E9E9E),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.border, width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.border, width: 1),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: LightColors.primary, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: LightColors.primary,
    selectionColor: LightColors.primary.withOpacity(0.3),
    selectionHandleColor: LightColors.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: LightColors.primary,
    foregroundColor: LightColors.text1,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColors.primary,
      foregroundColor: LightColors.backGround2,
      elevation: 0,
      shadowColor: Colors.transparent,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    side: BorderSide(color: LightColors.border, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
  ),
  iconTheme: IconThemeData(color: LightColors.text3.withOpacity(0.8)),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.backGround2;
      }
      return LightColors.text4;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.primary;
      }
      return LightColors.backGround;
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return LightColors.primary;
      }
      return LightColors.text4;
    }),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    padding: EdgeInsets.zero,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: LightColors.backGround,
    elevation: 10,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: LightColors.primary,
    unselectedItemColor: LightColors.text4,
    selectedLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    unselectedLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  ),
  dividerTheme: DividerThemeData(color: LightColors.border),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(color: LightColors.backGround),
);
