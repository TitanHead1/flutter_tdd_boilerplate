import 'package:flutter/material.dart';
import '../config/app_color.dart';
import '../config/app_images.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final String title;
  final void Function()? onPressed;
  const RoundedButton(
      {super.key,
        required this.colour,
        required this.title,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colour,
      elevation: 7,
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BackPressButton extends StatelessWidget {
  final void Function() onBack;

  const BackPressButton({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBack,
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.borderE8ECF4, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            AppImages.appLogo,
            height: 20,
            width: 20,
            color: AppColor.black06152B,
          )),
    );
  }
}

class BackButtonWithFilter extends StatelessWidget {
  final void Function() onBack;
  final bool showFilterIcon;
  final void Function()? onFilter;

  const BackButtonWithFilter({
    super.key,
    required this.onBack,
    this.showFilterIcon = false,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onBack,
          child: Container(
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                  color: AppColor.whiteFFFFFF,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.black323A48.withOpacity(.5),
                      blurRadius: 15,
                    ),
                  ]),
              child: Image.asset(
                AppImages.appLogo,
                height: 20,
                width: 20,
                // color: AppColor.black06152B,
              )),
        ),
        if (showFilterIcon)
          InkWell(
            onTap: onFilter,
            child: Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                    color: AppColor.whiteFFFFFF,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black323A48.withOpacity(.5),
                        blurRadius: 15,
                      ),
                    ]),
                child: Image.asset(
                  AppImages.appLogo,
                  height: 20,
                  width: 20,
                )),
          ),
      ],
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final double? height;
  final void Function() callBack;

  const GradientButton({
    super.key,
    required this.text,
    this.height,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: height ?? 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColor.appColor.withOpacity(.5),
                AppColor.appColor,
                // AppColor.btnGradientColor2.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColor.black323A48,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedSignOutButton extends StatelessWidget {
  final Color colour;
  final String title;
  final bool isIconShow;
  final void Function()? onPressed;
  const RoundedSignOutButton(
      {super.key,
        this.isIconShow = false,
        required this.colour,
        required this.title,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colour,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        onPressed: onPressed,
        //Go to login screen.
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String text;
  final double? height;
  final void Function() callBack;

  const BorderButton({
    super.key,
    required this.text,
    this.height,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Material(
        //elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          height: height ?? 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: AppColor.appColor.withOpacity(.7), width: 1.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColor.black323A48,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}



