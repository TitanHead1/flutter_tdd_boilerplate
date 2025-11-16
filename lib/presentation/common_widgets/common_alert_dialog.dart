import 'package:flutter/material.dart';

import '../config/app_color.dart';



showAlertDialog({required String msg, required BuildContext context}) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        msg.contains("Exception") ? msg.replaceAll("Exception: ", "") : msg,
        style: const TextStyle(
            color: AppColor.black323A48,
            fontWeight: FontWeight.normal,
            fontSize: 13),
      ),
    ),
    //insetPadding: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actions: [
      GestureDetector(
        onTap: () {
         Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              color: AppColor.appColor,
              borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Ok",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.whiteFFFFFF),
          ),
        ),
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogOnPressed(
    {required String? msg, required Function()? onPressed,required BuildContext context}) {
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: const EdgeInsets.only(top: 10),
    title: const Text(
      "Trickee",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColor.black323A48,
          fontWeight: FontWeight.bold,
          fontSize: 16),
    ),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        msg!,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: AppColor.black323A48,
            fontWeight: FontWeight.normal,
            fontSize: 13),
      ),
    ),
    //insetPadding: const EdgeInsets.all(10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsAlignment: MainAxisAlignment.center,
    actionsPadding: const EdgeInsets.only(bottom: 12),
    actions: [
      GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              color: AppColor.black323A48,
              borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Yes",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.whiteFFFFFF),
          ),
        ),
      ),
      const SizedBox(width: 20),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: 30,
          width: 80,
          decoration: BoxDecoration(
              color: AppColor.whiteFCFCFC,
              border: Border.all(color: AppColor.appColor,width: 1.2),
              borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "No",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.black323A48),
          ),
        ),
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

noInternetDialog({required Function() onRetry,required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text('No Internet Connection.'),
      content: const Text('Please check your internet connection and try.'),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.appColor,
            fixedSize: const Size.fromWidth(100),
            padding: const EdgeInsets.all(10),
          ),
          child: const Text("Retry"),
          onPressed: () {
           Navigator.pop(context);
            onRetry();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.appColor,
            fixedSize: const Size.fromWidth(100),
            padding: const EdgeInsets.all(10),
          ),
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    ),
  );
}

void showPopupMenu({required BuildContext context}) async {
  await showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(10, 90, 100, 100),
    items: [
      const PopupMenuItem(
        value: 1,
        child: Text(
          "Logout",
          style: TextStyle(color: AppColor.black323A48, fontSize: 14),
        ),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text(
          "Sign Up",
          style: TextStyle(color: AppColor.black323A48, fontSize: 14),
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {}
  });
}
