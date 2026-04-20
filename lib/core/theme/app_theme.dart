import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// App-wide [ThemeData] for light and dark modes.
abstract class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.surfaceBase,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          primaryContainer: AppColors.primaryContainer,
          secondary: AppColors.primaryLight,
          surface: AppColors.surfaceBase,
          error: AppColors.danger,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(
          TextTheme(
            displayLarge: AppTextStyles.displayLarge,
            displayMedium: AppTextStyles.displayMedium,
            headlineMedium: AppTextStyles.headlineMedium,
            titleMedium: AppTextStyles.titleMedium,
            bodyLarge: AppTextStyles.bodyLarge,
            bodyMedium: AppTextStyles.bodyMedium,
            labelLarge: AppTextStyles.labelLarge,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceBase,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.headlineMedium,
          iconTheme: const IconThemeData(color: AppColors.textPrimary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
            textStyle: AppTextStyles.labelLarge,
            shape: const StadiumBorder(),
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.surfaceBase,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.shadowDark,
          thickness: 1,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.surfaceBaseDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryLight,
          onPrimary: AppColors.surfaceBaseDark,
          primaryContainer: AppColors.primaryDark,
          secondary: AppColors.primary,
          surface: AppColors.surfaceBaseDark,
          error: AppColors.danger,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(
          TextTheme(
            displayLarge: AppTextStyles.displayLargeDark,
            displayMedium: AppTextStyles.displayMediumDark,
            headlineMedium: AppTextStyles.headlineMediumDark,
            titleMedium: AppTextStyles.titleMediumDark,
            bodyLarge: AppTextStyles.bodyLargeDark,
            bodyMedium: AppTextStyles.bodyMediumDark,
            labelLarge: AppTextStyles.labelLargeDark,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceBaseDark,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTextStyles.headlineMediumDark,
          iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: AppColors.surfaceBaseDark,
            textStyle: AppTextStyles.labelLargeDark,
            shape: const StadiumBorder(),
          ),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.surfaceBaseDark,
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.shadowDarkDark,
          thickness: 1,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryDark,
          size: 24,
        ),
      );
}
