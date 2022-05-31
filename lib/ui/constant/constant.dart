
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// --------------
/// Constant Color
/// --------------
Color primaryColor = const Color(0xffBF183C);
Color blackColor = const Color(0xff666666);
Color blackSolidColor = const Color(0xff222222);
Color grayColor = const Color(0xff999999);
Color redColor = const Color(0xffFF6564);
Color graySoftColor = const Color(0xffF6F6F6);
Color greenColor = const Color(0xff68BA75);

MaterialColor primaryCustomSwatch = MaterialColor(0xffFBBD1C, {
  50:  primaryColor,
  100: primaryColor,
  200: primaryColor,
  300: primaryColor,
  400: primaryColor,
  500: primaryColor,
  600: primaryColor,
  700: primaryColor,
  800: primaryColor,
  900: primaryColor,
});

/// --------------
/// Asset Location
/// --------------
/// Example: ${iconAsset}/logo.svg
String iconAsset = "assets/icons";
String imageAsset = "assets/images";

/// ------------
/// Device Size
/// ------------
double get deviceWidth => ScreenUtil().screenWidth;
double get deviceHeight => ScreenUtil().screenHeight;

/// ----------------
/// Status Bar Color
/// ----------------
void setStatusBar({Brightness brightness = Brightness.dark, Color color = Colors.transparent}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: color,
    statusBarIconBrightness: brightness)
  );
}

/// ----------------------------------- 
/// Font and size scaling screen utils
/// ----------------------------------- 
/// Initialize screen util and set default size
/// by device size
void setupScreenUtil(BuildContext context) {
  double baseWidth = MediaQuery.of(context).size.width;
  double baseHeight = MediaQuery.of(context).size.height;
  double defaultScreenUtilWidth = 1080;
  double defaultScreenUtilHeight = 1920;
  double iPadPro12InchWidth = 2048;
  double iPadPro12InchHeight = 2732;
  double designWidth = 0;
  double designHeight = 0;

  /// ipad 11-inch width: 834, height: 1194
  /// ipad 9-inch width: 768, height: 1024
  if (baseWidth >= 768) {
    designWidth = iPadPro12InchWidth;
  } else {
    designWidth = defaultScreenUtilWidth;
  }

  if (baseHeight >= 1024) {
    designHeight = iPadPro12InchHeight;
  } else {
    designHeight = defaultScreenUtilHeight;
  }

  ScreenUtil.init(
    context,
    deviceSize: Size(baseWidth, baseHeight),
    designSize: Size(designWidth, designHeight),
    orientation: Orientation.portrait
  );
}

bool isLargePhone(BuildContext context) => MediaQuery.of(context).size.width > 600 ? true : false;
bool isNormalPhone(BuildContext context) => MediaQuery.of(context).size.width > 400 && MediaQuery.of(context).size.width < 600 ? true : false;
bool isSmallPhone(BuildContext context) => MediaQuery.of(context).size.width < 400 ? true : false;
bool isSmallPhoneHeight(BuildContext context) => MediaQuery.of(context).size.height < 700 ? true : false;

/// Setting height and width 
double setWidth(double width) => ScreenUtil().setWidth(width);
double setHeight(double height) => ScreenUtil().setHeight(height);

/// Setting fontsize
double setFontSize(double size) => ScreenUtil().setSp(size);

/// ----------------------------------- 
/// Constant Base Text Styling
/// ----------------------------------- 

TextStyle styleTitle = TextStyle(
  fontSize: setFontSize(36),
  color: blackColor,
  fontWeight: FontWeight.w700
);

TextStyle styleSubtitle = TextStyle(
  fontSize: setFontSize(32),
  color: blackColor
);