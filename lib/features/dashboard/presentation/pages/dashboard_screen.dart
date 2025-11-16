import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../../../presentation/common_widgets/common_alert_dialog.dart';
import '../../../../presentation/config/app_color.dart';
import '../../../../presentation/config/app_images.dart';
import '../../../../presentation/config/typography_font_style.dart';
import '../../../product/presentation/bloc/product_home_bloc.dart';
import '../../../product/presentation/pages/product_home_page.dart';
import '../cubit/dashboard_cubit.dart';
import '../widgets/menu_button.dart';
import 'navigation_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> dashboardTabsList = <Widget>[
    const ProductHomePage(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Duration time) => init());
    super.initState();
  }

  init() async {
    context.read<ProductHomeBloc>().add(const ProductFetchAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        showAlertDialogOnPressed(
            msg: Constants.doYouWantExitFromApp,
            onPressed: () {
              SystemNavigator.pop();
            },
            context: context);
      },
      child: BlocBuilder<DashboardCubit, int>(
        builder: (context, index) {
          return Scaffold(
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              elevation: 1,
              leading: const MenuButton(),
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              title:  Text(Constants.appTitle,
                  textAlign: TextAlign.center,
                  style: TypographyFontStyle.semiBold.copyWith(
                    color: AppColor.black,
                    fontSize: 20,
                  )
              ),
              actions: [
                Image.asset(AppImages.appLogo, height: 30, width: 30),
                const SizedBox(width: 30),
              ],
            ),
            body: dashboardTabsList.elementAt(index),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined, size: 25), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border, size: 25), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.access_time, size: 25), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle_outlined, size: 25),
                      label: ""),
                ],
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: AppColor.whiteFCFCFC,
                onTap: (int index) {
                  context.read<DashboardCubit>().onTap(index);
                },
                elevation: 5),
          );
        },
      ),
    );
  }
}
