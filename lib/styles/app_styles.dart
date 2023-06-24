import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {
  TextStyle appBarTextStyle = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );

  TextStyle appBarBlackTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
  );
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
