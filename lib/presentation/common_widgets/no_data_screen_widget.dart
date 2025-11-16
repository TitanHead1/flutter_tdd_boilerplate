import 'package:flutter/material.dart';

import '../config/app_color.dart';
import '../config/app_images.dart';

class NoDataScreen extends StatelessWidget {
  final String? message;
  const NoDataScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 200,
            width: 300,
            alignment: Alignment.center,
            child: Image.asset(AppImages.appLogo),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(message ?? "No Data Found.",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 150,
          ),
        ],
      ),
    );
  }
}

class NoDataMessage extends StatelessWidget {
  final String message;
  const NoDataMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
          child: Text(
        message,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColor.black4F4F4F),
      )),
    );
  }
}
