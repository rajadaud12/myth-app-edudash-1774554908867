import 'package:flutter/material.dart';
import 'package:edudash_app/utils/colors.dart'; 
import 'package:edudash_app/screens/home.dart'; 
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(EduDashApp());
}

class EduDashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(padding: const EdgeInsets.only(top: 44.0, bottom: 34.0)), child: child!), 
      title: 'EduDash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
        ),
      ),
      home: HomeScreen(),
    );
  }
}