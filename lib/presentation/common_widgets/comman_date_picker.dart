import 'package:flutter/material.dart';
import '../config/app_color.dart';


class TextFormFieldDatePicker extends StatefulWidget {
  const TextFormFieldDatePicker({
    Key? key,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    this.isStar = false,
    required this.title,
    this.textStyleTitle = const TextStyle(fontSize: 16, color: AppColor.black06152B),
    this.controller,
    this.validator,
    this.hintText,
    this.keyboardType = TextInputType.emailAddress,
    this.colorFill = Colors.white,
    this.colorBorder = Colors.black,
    this.colorHint = Colors.grey,
    this.colorText = Colors.black,
    this.textStyle = const TextStyle(fontSize: 16, color: AppColor.black06152B),
    this.radiusBorder = 8.0,
    this.maxLines = 1,
    this.keyCustom,
  }) : super(key: key);

  // final List? list;
  final EdgeInsets padding;
  final Function()? onTap;

  // final String? selectedText;
  final String? title;
  final TextStyle? textStyleTitle;
  final bool? isStar;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  final TextInputType? keyboardType;
  final String? hintText;
  final Color? colorFill;
  final Color? colorBorder;
  final Color? colorText;
  final Color? colorHint;
  final TextStyle? textStyle;
  final double? radiusBorder;
  final int? maxLines;
  final Key? keyCustom;

  @override
  State<TextFormFieldDatePicker> createState() =>
      _TextFormFieldDatePickerState();
}

class _TextFormFieldDatePickerState extends State<TextFormFieldDatePicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 50,
      child: GestureDetector(
      onTap: widget.onTap,
        child: Column(
          children: [
            TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              key: widget.keyCustom,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              minLines: 1,
              style: widget.textStyle!.apply(
                // color: Colors.black.
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: const BorderSide(width: 1,color:  Colors.grey ), borderRadius: BorderRadius.circular(5)),
                disabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1,color: Colors.grey), borderRadius: BorderRadius.circular(5)),
                errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1,color: Colors.red), borderRadius: BorderRadius.circular(5)),

                isDense: true,                      // Added this
                contentPadding: const EdgeInsets.all(16),  // Added this
                // label: Text(label),

              ),
              enabled: false,
              // onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
