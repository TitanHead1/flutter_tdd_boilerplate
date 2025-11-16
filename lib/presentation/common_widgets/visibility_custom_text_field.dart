import 'package:flutter/material.dart';
import '../config/app_color.dart';

class VisibilityCustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool passwordVisible;
  final bool showSuffixIcon;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onPressed;
  final VoidCallback? onPasswordVisible;
  final int maxLines;
  final TextInputAction textInputAction;

  const VisibilityCustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.passwordVisible = false,
    this.showSuffixIcon = true,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onPressed,
    this.onPasswordVisible,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onPressed,
      maxLines: maxLines,
      obscureText: passwordVisible,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: AppColor.greyB2B2B2,
            fontWeight: FontWeight.w400,
            fontSize: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColor.greyD1D5DB),
            borderRadius: BorderRadius.circular(6)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColor.greyD1D5DB),
            borderRadius: BorderRadius.circular(6)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: AppColor.greyD1D5DB),
            borderRadius: BorderRadius.circular(6)),
        suffixIcon: IconButton(
          color: AppColor.appColor,
          icon: Icon(
            passwordVisible ? Icons.visibility_off_outlined : Icons.visibility,
            size: 22,
          ),
          onPressed: onPasswordVisible,
        ),
      ),
      validator: validator,
      textInputAction: textInputAction,
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
