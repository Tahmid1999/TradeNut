import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../views/login_screen.dart';
import '../views/peanut_full_app_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // replace this with your duration

    Future.delayed(const Duration(seconds: 2), () async {

      const storage = FlutterSecureStorage();
      if(await storage.read(key: 'token')!= null){
        Get.offAll(const PeanutFullApp());
      }
      else{
        Get.offAll(const LoginScreen());
      }

    });
  }
}

