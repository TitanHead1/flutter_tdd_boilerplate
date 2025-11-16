import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_images.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_route_path.dart';
import 'core/utils/app_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      if(AppUtils.checkUserLogin()){
        context.pushReplacement(AppRoutePath.dashboard);
      }else{
        context.pushReplacement(AppRoutePath.loginPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset(
              AppImages.splashImage,
              // fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
