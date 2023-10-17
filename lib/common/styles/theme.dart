import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdemo_app/common/styles/colors.dart';

class ZSTheme {
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    letterSpacing: .4,
    fontWeight: FontWeight.w700,
    height: 1.5,
    color: ZSColors.primaryDark,
  );

  static const TextStyle _overline = TextStyle(
    fontSize: 12,
    letterSpacing: .5,
    fontWeight: FontWeight.w500,
    height: 1.33,
    color: ZSColors.secondaryDark,
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: ZSColors.primary,
    primaryColorDark: ZSColors.primaryDark,
    scaffoldBackgroundColor: Colors.white,
    unselectedWidgetColor: ZSColors.neutralLight40,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: ZSColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: ZSColors.primary,
      foregroundColor: ZSColors.neutralLight20,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: ZSColors.neutralLight20,
      ),
      iconTheme: IconThemeData(
        color: ZSColors.neutralLight20,
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: ZSColors.primaryDark,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: ZSColors.primaryB400, width: 2),
      ),
      labelStyle: TextStyle(
        color: ZSColors.primary,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
      unselectedLabelColor: ZSColors.secondaryDark,
      unselectedLabelStyle: TextStyle(
        color: ZSColors.secondaryDark,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ZSColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        minimumSize: const Size(80, 44),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: ZSColors.primaryB50,
        foregroundColor: ZSColors.primary,
        textStyle: const TextStyle(
          fontSize: 16.0,
          color: ZSColors.primary,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        side: BorderSide.none,
        minimumSize: const Size(80, 44),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ZSColors.primary,
        textStyle: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: ZSColors.primaryDark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: ZSColors.neutralLight10,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: ZSColors.primaryB300,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: ZSColors.neutralLight40,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: ZSColors.neutralLight40,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: ZSColors.neutralLight30,
        ),
      ),
      hintStyle: TextStyle(
        color: ZSColors.secondaryDark,
      ),
      errorStyle: TextStyle(
        fontSize: 12,
        letterSpacing: .4,
        fontWeight: FontWeight.normal,
        color: ZSColors.error,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ZSColors.error,
          width: 2,
        ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: ZSColors.divider,
      thickness: 1.0,
      space: 1.0,
    ),
    radioTheme: RadioThemeData(
      fillColor: fillColorProperty(),
      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: fillColorProperty(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      highlightElevation: 0,
      foregroundColor: ZSColors.primary,
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 28,
        letterSpacing: .4,
        fontWeight: FontWeight.w300,
        height: 1.29,
        color: ZSColors.primaryDark,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: ZSColors.primaryDark,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.33,
        color: ZSColors.primaryDark,
        letterSpacing: -.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        letterSpacing: .4,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: ZSColors.primaryDark,
      ),
      bodyMedium: bodyMedium,
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: ZSColors.primaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        letterSpacing: .4,
        fontWeight: FontWeight.w400,
        height: 1.33,
        color: ZSColors.primaryDark,
      ),
      labelSmall: _overline,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ZSColors.primaryB300,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ZSColors.neutralLight00,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    ),
    colorScheme: const ColorScheme(
      primary: ZSColors.primary,
      secondary: ZSColors.secondary,
      onSecondary: ZSColors.neutralLight00,
      onPrimary: ZSColors.neutralLight00,
      background: ZSColors.neutralLight00,
      brightness: Brightness.light,
      error: ZSColors.error,
      onBackground: ZSColors.primaryDark,
      onError: ZSColors.neutralLight00,
      onSurface: ZSColors.secondaryDark,
      surface: ZSColors.neutralLight00,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      refreshBackgroundColor: ZSColors.neutralLight10,
    ),
    dataTableTheme: DataTableThemeData(
      dataRowMinHeight: 48,
      headingRowHeight: 32,
      horizontalMargin: 16,
      columnSpacing: 16,
      dividerThickness: 0,
      checkboxHorizontalMargin: 16,
      dataTextStyle: bodyMedium,
      headingTextStyle: _overline.copyWith(
        color: ZSColors.secondaryDark,
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: MaterialStateProperty.all(8),
      radius: const Radius.circular(20),
      interactive: true,
    ),
  );
}

extension TextThemeExtension on TextTheme {
  TextStyle? get title1 {
    return titleLarge;
  }

  TextStyle? get title2 {
    return titleLarge?.copyWith(
      fontSize: 18,
      height: 1.33,
      letterSpacing: -0.5,
    );
  }

  TextStyle? get title3 {
    return titleLarge?.copyWith(
      fontSize: 16,
      height: 1.5,
    );
  }

  TextStyle? get title4 {
    return titleLarge?.copyWith(
      fontSize: 14,
      height: 1.43,
    );
  }

  TextStyle? get display1 {
    return titleLarge?.copyWith(
      fontSize: 32,
      height: 36 / 32,
    );
  }

  TextStyle? get largeDisplay {
    return titleLarge?.copyWith(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w400,
      letterSpacing: .4,
    );
  }
}

Color fillColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.selected)) {
    return ZSColors.primaryB400; // the color when checkbox is selected;
  }
  return ZSColors.neutralLight40; //the color when checkbox is unselected;
}

MaterialStateProperty<Color> fillColorProperty() {
  return MaterialStateProperty.resolveWith(fillColor);
}
