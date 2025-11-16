import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tdd_boilerplate/core/utils/app_log.dart';
import 'package:flutter_tdd_boilerplate/presentation/common_widgets/app_prompt.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_color.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_images.dart';
import 'package:flutter_tdd_boilerplate/presentation/config/app_route_path.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/shared_preferences.dart';
import '../../../../main.dart';
import '../../../../presentation/common_widgets/common_alert_dialog.dart';
import '../../../../presentation/common_widgets/common_button.dart';
import '../../../../presentation/common_widgets/custom_text_field.dart';
import '../../../../presentation/common_widgets/visibility_custom_text_field.dart';
import '../../../../presentation/config/typography_font_style.dart';
import '../../../dashboard/presentation/cubit/dashboard_cubit.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextField = TextEditingController(text: "");
  final TextEditingController passwordTextField = TextEditingController(
      text: "");
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;


  @override
  void dispose() {
    emailTextField.dispose();
    passwordTextField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pageColorF2F4F7,
        body: Form(
          key: loginKey,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 50),
                Image.asset(AppImages.loginPageImage),
                const SizedBox(height: 30),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                         Text(Constants.tickTalkLogin,
                            textAlign: TextAlign.center,
                            style: TypographyFontStyle.semiBold.copyWith(
                              color: AppColor.black,
                              fontSize: 20,
                            )
                            ),
                        const SizedBox(height: 30),
                         Text(Constants.emailAddress,
                            style: TypographyFontStyle.medium.copyWith(
                              color: AppColor.black,
                              fontSize: 14,
                            )),
                        const SizedBox(height: 10),
                        CustomTextField(
                          textInputAction: TextInputAction.next,
                          controller: emailTextField,
                          autofocus: false,
                          hintText: Constants.enterEmailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return Constants.pleaseEnterEmail;
                            } else if (!AppValidation.isValidEmail(value)) {
                              return Constants.pleaseEnterValidEmail;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                         Text(Constants.password,
                            style: TypographyFontStyle.medium.copyWith(
                              color: AppColor.black,
                              fontSize: 14,
                            )),
                        const SizedBox(height: 10),
                        VisibilityCustomTextField(
                            textInputAction: TextInputAction.next,
                            controller: passwordTextField,
                            hintText: Constants.enterPasswordAddress,
                            onPasswordVisible: () {
                              isPasswordVisible = !isPasswordVisible;
                              setState(() {});
                            },
                            passwordVisible: isPasswordVisible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return Constants.pleaseEnterPassword;
                              }
                              if (value.length < 8) {
                                return Constants.thePasswordMustLeastEightCharacters;
                              }
                              return null;
                            }),
                        const SizedBox(height: 50),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            AppLog.printLog("AuthBlocState : $state");
                            if (state is AuthLoading) {
                              AppPrompt.showLoader(context);
                            }
                            if (state is AuthFailure) {
                              AppPrompt.hideLoader();
                              AppPrompt.showToast(mgs: state.message);
                            }
                            if (state is AuthSuccess) {
                              AppPrompt.hideLoader();
                              sp!.putBool(SpUtil.isLoggedIn, true);
                              sp!.putString(
                                  SpUtil.userID, state.user.id.toString());
                              context.read<DashboardCubit>().onTap(0);
                              context.go(AppRoutePath.dashboard);

                            }
                          },
                          child: RoundedButton(
                            title: Constants.login,
                            colour: AppColor.appColor,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.go(AppRoutePath.dashboard);
                              // final isValid = loginKey.currentState!.validate();
                              // if (!isValid) {
                              //   return;
                              // } else {
                              //   context.read<AuthBloc>().add(AuthLogin(
                              //       email: emailTextField.text.toString(),
                              //       password: passwordTextField.text.toString()));
                              // }
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
