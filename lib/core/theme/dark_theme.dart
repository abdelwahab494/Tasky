import 'package:tasky/core/imports.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: DarkColors.backGround,
  primaryColor: DarkColors.primary,
  colorScheme: ColorScheme.dark(
    primaryContainer: DarkColors.backGround2,
    secondaryContainer: Colors.grey.shade800,
    outline: DarkColors.backGround2,
    shadow: DarkColors.text3,
    error: Colors.red.shade700,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: DarkColors.backGround,
    titleTextStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: DarkColors.text2,
      fontSize: 22,
    ),
    iconTheme: IconThemeData(color: DarkColors.text2),
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  textTheme: TextTheme(
    displayMedium: GoogleFonts.plusJakartaSans(
      color: DarkColors.text1,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: GoogleFonts.poppins(
      color: DarkColors.text2,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: GoogleFonts.poppins(
      color: DarkColors.text3,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.roboto(
      color: DarkColors.text3,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      decoration: TextDecoration.none,
      decorationColor: DarkColors.text4,
      decorationThickness: 2,
    ),
    //* for done task
    labelMedium: GoogleFonts.poppins(
      color: DarkColors.text4,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      decoration: TextDecoration.lineThrough,
      decorationColor: DarkColors.text4,
      decorationThickness: 2,
    ),
    labelSmall: GoogleFonts.roboto(
      color: DarkColors.text4.withOpacity(0.5),
      fontWeight: FontWeight.w400,
      fontSize: 14,
      decoration: TextDecoration.lineThrough,
      decorationColor: DarkColors.text4.withOpacity(0.5),
      decorationThickness: 2,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DarkColors.backGround2,
    hintStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xff6D6D6D),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: DarkColors.primary, width: 2),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: DarkColors.primary,
    selectionColor: DarkColors.primary.withOpacity(0.3),
    selectionHandleColor: DarkColors.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: DarkColors.primary,
    foregroundColor: DarkColors.text1,
    elevation: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkColors.primary,
      foregroundColor: DarkColors.text2,
      elevation: 0,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    side: BorderSide(color: DarkColors.border, width: 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4),
    ),
  ),
  iconTheme: IconThemeData(color: DarkColors.text3),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(DarkColors.text1),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return DarkColors.primary;
      }
      return DarkColors.text4.withOpacity(0.4);
    }),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    overlayColor: WidgetStateProperty.all(DarkColors.primary.withOpacity(0.15)),
    padding: EdgeInsets.zero,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 10,
    backgroundColor: DarkColors.backGround,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: DarkColors.primary,
    unselectedItemColor: DarkColors.text3,
    selectedLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    unselectedLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
  ),
  dividerTheme: DividerThemeData(color: DarkColors.border),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(shadowColor: Colors.black38),
);
