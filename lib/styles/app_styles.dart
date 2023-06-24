import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  static ButtonStyle primaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
    foregroundColor: MaterialStateProperty.all(AppColors.whiteColor),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
  );

  static ButtonStyle darkPrimaryButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.darkPrimaryColor),
    foregroundColor: MaterialStateProperty.all(AppColors.whiteColor),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
  );

  static TextStyle blackSmallBoldTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
  );
}
