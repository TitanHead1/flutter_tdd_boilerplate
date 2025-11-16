import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/app_color.dart';
import '../../core/utils/app_log.dart';
import '../../core/utils/enum_constant.dart';

class AppPrompt {
  //close all
  static closeAll(BuildContext context) {
    try {
      Navigator.of(context).pop(true);
    } catch (e) {
      debugPrint("error => $e");
    }
  }

  //show toast
  static showToast({required String mgs}) {
    Fluttertoast.showToast(
      msg: mgs.contains("Exception") ? mgs.replaceAll("Exception: ", "") : mgs,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static showSnack({required String mgs, required MgsType type}) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      msg: mgs,
      toastLength: Toast.LENGTH_LONG,
      textColor:
          type == MgsType.success ? AppColor.green71dc4d : AppColor.greyF0F0F0,
    );
  }

  static snackWarning(
      {required BuildContext context,
      required String mgs,
      required MgsType type}) {
    final scaffold = Scaffold.of(context);
    var snackBar = SnackBar(
      // action: SnackBarAction(
      //   label: "Ok",
      //   onPressed: () {},
      //   textColor: textcolor ?? Colors.white,
      // ),
      behavior: SnackBarBehavior.floating,
      content: Text(
        mgs,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor:
          type == MgsType.success ? AppColor.green71dc4d : AppColor.greyF0F0F0,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static BuildContext? _dialogContext;

  // show loader dialog
  static showLoader(BuildContext context) {
    AppLog.printLog("showLoader $context");
    _dialogContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (BuildContext buildContext) {
        //_dialogContext = buildContext;
        return PopScope(
          canPop: false,
          child: Container(
            color: Colors.grey.withOpacity(.3),
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColor.black323A48,
              ),
            ),
          ),
        );
      },
    );
  }

  static hideLoader() {
    AppLog.printLog("hideLoader $_dialogContext");
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
