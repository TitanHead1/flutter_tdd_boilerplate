// typography_font_style.dart
import 'package:flutter/material.dart';

const String _fontFamily = 'Roboto';

class TypographyFontStyle  {
  static TextStyle black =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w900);

  static TextStyle extraBold =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w800);

  static TextStyle bold =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w700);

  static TextStyle semiBold =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w600);

  static TextStyle medium =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w500);

  static TextStyle regular =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w400);

  static TextStyle thin =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w300);

  static TextStyle light =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w200);

  static TextStyle extraLight =
  const TextStyle(fontFamily: _fontFamily, fontWeight: FontWeight.w100);
}