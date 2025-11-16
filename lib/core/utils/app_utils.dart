import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_tdd_boilerplate/core/utils/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../presentation/config/app_color.dart';
import 'app_log.dart';

class AppUtils {
  static void logOut() async {
    AppLog.printLog("LogOut");
    if (checkRememberMe()) {
      String email = sp!.getString(SpUtil.userEmail);
      String password = sp!.getString(SpUtil.userPassword);
      sp!.clear();
      sp = await SpUtil.getInstance();
      sp!.putBool(SpUtil.isRememberMe, true);
      sp!.putString(SpUtil.userEmail, email);
      sp!.putString(SpUtil.userPassword, password);
    } else {
      sp!.clear();
      sp = await SpUtil.getInstance();
      /*FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();*/
      AppLog.printLog("Access Token ===> ${sp!.getString(SpUtil.accessToken)}");
    }
  }

  static bool checkUserLogin() {
    bool isLoggedIn = sp!.getBool(SpUtil.isLoggedIn) ?? false;
    if (isLoggedIn) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkVehicleAdded() {
    bool isLoggedIn = sp!.getBool(SpUtil.isVehicleAdded) ?? false;
    if (isLoggedIn) {
      return true;
    } else {
      return false;
    }
  }

  /*static Future<LocationData> getCurrentAddress() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    locationData = await location.getLocation();

    return locationData;
  }*/

  static bool checkRememberMe() {
    bool isRememberMe = sp!.getBool(SpUtil.isRememberMe) ?? false;
    if (isRememberMe) {
      return true;
    } else {
      return false;
    }
  }

  static void getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    await sp!.getString(SpUtil.deviceUniqueId).then((value) async {
      if (value.trim().isEmpty) {
        AppLog.printLog("if case");
        if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

          sp!.putString(SpUtil.deviceType, "IOS");
          sp!.putString(SpUtil.deviceUniqueId, iosInfo.identifierForVendor!);
        } else {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

          sp!.putString(SpUtil.deviceType, "IOS");
          sp!.putString(SpUtil.deviceUniqueId, androidInfo.id);
        }
      }
    });
  }

  /// convert value in thousand format
  static String convertValueInThousandFormat({required String inputString}) {
    final f = NumberFormat.decimalPattern('hi');
    return f.format(double.parse(inputString));
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static int getRandomColor(int position) {
    int? color;
    if (position % 4 == 0) {
      color = AppColor.randomClr1;
    } else if (position % 4 == 1) {
      color = AppColor.randomClr2;
    } else if (position % 4 == 2) {
      color = AppColor.randomClr3;
    } else if (position % 4 == 3) {
      color = AppColor.randomClr4;
    }
    return color!;
  }

  static String runeSubstring([String? input, int? start, int? end]) {
    return String.fromCharCodes(
      input!.runes.toList().sublist(
            start!,
            end,
          ),
    );
  }

  static String toTitleCase(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static int randomNumber() {
    var rng = Random();
    return rng.nextInt(90000000);
  }

  static String getDateFromUtc(String utcDate, String pattern) {
    var strToDateTime = DateTime.parse(utcDate.toString());
    final convertLocal = strToDateTime.toLocal();
    var newFormat = DateFormat(pattern);
    String updatedDt = newFormat.format(convertLocal);
    return updatedDt;
  }

  static String convertDateYYYYMMDD(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String convertDateDdMmYyyy(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String convertDateFormat(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(date); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd/MM/yyyy');
    String outputDate = outputFormat.format(inputDate);
    // final DateFormat formatter = DateFormat('dd-MM-yyyy');
    // final String formattedDate = formatter.format(DateTime.parse(date));
    return outputDate.toString();
  }

  static String convertTripTime(String totalDuration) {
    var outputFormat = totalDuration
        .replaceAll("hours", "hr")
        .replaceAll("minutes", "min")
      .replaceAll("second", "sec");
    return outputFormat.toString();
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
