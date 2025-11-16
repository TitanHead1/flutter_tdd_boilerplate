import 'package:flutter/material.dart';
import '../config/app_color.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
          //child: CupertinoActivityIndicator(radius: 16)
          child: CircularProgressIndicator(
            color: AppColor.black323A48,
          )
      ),
    );
  }
}
