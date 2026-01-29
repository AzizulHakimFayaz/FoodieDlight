import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_colors.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodieDelight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .copyWith(
              displayLarge: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
              displayMedium: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
              headlineLarge: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
              headlineMedium: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
              titleLarge: GoogleFonts.playfairDisplay(
                fontWeight: FontWeight.bold,
              ),
            ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
