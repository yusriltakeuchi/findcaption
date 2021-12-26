import 'dart:io';

import 'package:findcaption/core/config/config.dart';
import 'package:findcaption/core/utils/navigation/navigation_utils.dart';
import 'package:findcaption/injector.dart';
import 'package:findcaption/provider_starter.dart';
import 'package:findcaption/ui/constant/constant.dart';
import 'package:findcaption/ui/router/route_list.dart';
import 'package:findcaption/ui/router/router_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  /// Fixing  CERTIFICATE_VERIFY_FAILED
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();

  /// Registering providers
  List<SingleChildWidget>? providers = await ProviderStarter.register();
  runApp(MyApp(
    providers: providers,
  ),);
}


class MyApp extends StatelessWidget {
  final List<SingleChildWidget>? providers;
  const MyApp({Key? key, 
    @required this.providers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      navigatorKey: locator<NavigationUtils>().navigatorKey,
      title: 'Find Caption',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), //set desired text scale factor here
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          ),
        );
      },
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        primarySwatch: primaryCustomSwatch,
        fontFamily: fontName,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
        scaffoldBackgroundColor: Colors.white,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          },
        ),
        colorScheme: const ColorScheme.light().copyWith(
          primary: primaryColor,
          onPrimary: primaryColor
        ).copyWith(secondary: primaryColor),
      ),
      initialRoute: routeHome,
      onGenerateRoute: RouterGenerator.generate,
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}