import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_boilerplate/core/constants/constants.dart';
import 'package:flutter_tdd_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_tdd_boilerplate/features/product/presentation/bloc/product_home_bloc.dart';
import 'package:flutter_tdd_boilerplate/presentation/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_router.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_theme.dart';
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'presentation/common_widgets/app_prompt.dart';
import 'core/utils/enum_constant.dart';
import 'core/utils/shared_preferences.dart';
import 'init_dependencies.dart';

SpUtil? sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SpUtil.getInstance();
  initDependencies();

  SystemChannels.textInput.invokeMethod('TextInput.hide');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // top status bar color
    systemNavigationBarColor: Colors.white, // bottom navigation bar color
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.dark, // For iOS (dark icons)
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ConnectivityBloc>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<DashboardCubit>()),
        BlocProvider(create: (_) => serviceLocator<ProductHomeBloc>()),
      ],
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          debugPrint("connectivityState : ${state.toString()}");

          if (state is ConnectivityLostState) {
            AppPrompt.showSnack(
              type: MgsType.error,
              mgs: Constants.noConnectionErrorMessage,
            );
            // return const NoInternetWidget();
          } else if (state is ConnectivityRecoverState) {
            AppPrompt.showSnack(
              type: MgsType.success,
              mgs: Constants.backOnline,
            );
          }
        },
        child: MaterialApp.router(
          title: Constants.appTitle,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
