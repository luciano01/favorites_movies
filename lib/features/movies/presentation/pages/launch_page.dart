import 'package:favorites_movies/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.offNamed('/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_movies,
              color: AppColors.accent,
              size: 128,
            ),
            Text(
              'Favorites'.toUpperCase(),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 32,
              ),
            ),
            Text(
              'Movies'.toUpperCase(),
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
