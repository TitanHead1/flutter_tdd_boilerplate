import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../presentation/common_widgets/common_alert_dialog.dart';
import '../../../../presentation/common_widgets/common_button.dart';
import '../../../../presentation/common_widgets/network_image_widget.dart';
import '../../../../presentation/config/app_color.dart';
import '../../../../presentation/config/app_images.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  ///instance of PackageInfo
  PackageInfo? packageInfo;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    _initPackageInfo();
    super.initState();
  }

  init() {
    _initPackageInfo();
  }

  ///init package info details
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.pageColorF2F4F7,
      // Disable opening the drawer with a swipe gesture.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 16, right: 10, bottom: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    width: 40,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: AppColor.greyB2B2B2,
                        size: 30,
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            //ListView
            child: Column(
              children: [
                Container(
                  //color: Colors.red,
                  padding: const EdgeInsets.only(
                    left: 16,
                  ), //BoxDecoration
                  child: const ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: NetworkImageWidget(
                          fit: BoxFit.fill,
                          imageUrl:
                              "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
                        ),
                      ),
                    ),
                    title: Text(
                      "User",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: AppColor.black323A48),
                    ),
                    subtitle: Text(
                      "User@gmail.com",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColor.greyB2B2B2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                drawerItems(
                    image: Icons.account_balance_wallet_outlined,
                    name: 'Account',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColor.greyB2B2B2),
                ),
                drawerItems(
                    image: Icons.manage_history_rounded,
                    name: 'Manage Team',
                    onPressed: () async {
                      Scaffold.of(context).openEndDrawer();
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColor.greyB2B2B2),
                ),
                drawerItems(
                    image: Icons.help_outline,
                    name: 'Help',
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColor.greyB2B2B2),
                ),
                drawerItems(
                    image: Icons.feedback_outlined,
                    name: 'Submit Feedback',
                    onPressed: () {
                      // Get.back();
                    }),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(color: AppColor.greyB2B2B2),
                ),
                const SizedBox(height: 16),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: RoundedSignOutButton(
                      colour: AppColor.appColor,
                      title: "SignOut",
                      onPressed: () {
                        showAlertDialogOnPressed(
                            msg: 'Are you sure you want to logout? ',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            context: context);
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "App Version:  ${packageInfo?.version}",
                    style: const TextStyle(
                        color: AppColor.greyB2B2B2,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  drawerItems(
      {required IconData image,
      required String name,
      required Function()? onPressed}) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
      minVerticalPadding: 0,
      leading: SizedBox(
        width: 30,
        child: Icon(image),
      ),
      minLeadingWidth: 20,
      title: Text(
        name,
        style: const TextStyle(
            color: AppColor.black4F4F4F,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      onTap: onPressed,
    );
  }
}
