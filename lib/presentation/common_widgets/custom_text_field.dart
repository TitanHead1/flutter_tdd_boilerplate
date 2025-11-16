import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onPressed;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatter;
  final int maxLines;
  final bool autofocus;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.isObscure = false,
      required this.textInputAction,
      this.inputFormatter,
      this.enabled = true,
      this.readOnly = false,
      this.maxLines = 1,
      this.autofocus = true,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      onTap: onPressed,
      maxLines: maxLines,
      maxLength: 200,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        counterText: '',
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
      ),
      validator: validator,
      autofocus: autofocus,
      textInputAction: textInputAction,
    );
  }
}
