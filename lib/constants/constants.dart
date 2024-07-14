import 'package:flutter/material.dart';

class Images {
  static Image logo = const Image(image: AssetImage('assets/small_logo.png'));
  static Image tutorial1 =
      const Image(image: AssetImage('assets/tutorial_1.png'));
  static Image tutorial2 =
      const Image(image: AssetImage('assets/tutorial_2.png'));
  static Image hipaa = const Image(image: AssetImage('assets/hipaa.png'));
  static Image largeLogo =
      const Image(image: AssetImage('assets/large_logo.png'));
  static Image homeHero =
      const Image(image: AssetImage('assets/home_hero.png'));
  static Icon diagnosisImage =
      Icon(Icons.bar_chart_rounded, color: ThemeColors.blueText);
  static Icon recommendationImage =
      Icon(Icons.medical_services_rounded, color: ThemeColors.blueText);

  static Icon riskImage =
      Icon(Icons.stacked_line_chart_rounded, color: ThemeColors.blueText);
  static Icon doubleArrow =
      Icon(Icons.mobile_screen_share_rounded, color: ThemeColors.blueText);
}

class ThemeColors {
  static Color darkBackground = const Color(0xFF1e1f25);
  static Color darkOutline = const Color(0xFF8E9099);
  static Color text = const Color(4293059305);
  static Color blueText = const Color(0xFFD8E2FF);
}

class TextStyles {
  static TextStyle largeTitle = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static TextStyle largeTitleBlue =
      largeTitle.copyWith(color: ThemeColors.blueText);

  static TextStyle smallTitle = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle smallTitleBlue =
      smallTitle.copyWith(color: ThemeColors.blueText);

  static TextStyle largeBody = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  static TextStyle largeBodyBlue =
      largeBody.copyWith(color: ThemeColors.blueText);

  static TextStyle smallBody = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle smallBodyBlue =
      smallBody.copyWith(color: ThemeColors.blueText);

  static TextStyle smallHeadline = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  static TextStyle smallHeadlineBlue =
      smallHeadline.copyWith(color: ThemeColors.blueText);

  static TextStyle largeHeadline = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static TextStyle largeHeadlineBlue =
      largeHeadline.copyWith(color: ThemeColors.blueText);

  static TextStyle smallLabel = TextStyle(
    fontFamily: 'Manrope',
    color: ThemeColors.text,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static TextStyle smallLabelBlue =
      smallLabel.copyWith(color: ThemeColors.blueText);
}
