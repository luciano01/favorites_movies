import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:favorites_movies/features/movies/presentation/pages/app_page.dart';
import 'package:favorites_movies/features/movies/presentation/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorites Movies',
      theme: ThemeData(
        primaryColor: AppColors.background,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.accent,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const AppPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/details',
          page: () => const DetailsPage(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
