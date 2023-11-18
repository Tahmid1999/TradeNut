
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:simple_app/views/theme/app_theme.dart';

import '../controller/splashscreen_controller.dart';
import '../helperFunction/HelperFunction.dart';


class SplashScreen extends StatelessWidget {
  ThemeData theme  = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  @override
  Widget build(BuildContext context) {
    HelperFunction.changeSystemUIColor(Colors.white, Colors.white);


    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset("assets/images/peanut.png",
              width: 200.0, // Adjust the width as needed
              height: 200.0
            )
          ),
        );
      },
    );

  }
}



