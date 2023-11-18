import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:simple_app/models/Auth.dart';

import '../api/api.dart';
import '../api/api_post_calls.dart';
import '../helperFunction/HelperFunction.dart';
import '../views/Dialogue.dart';
import '../views/home_screen.dart';
import '../views/peanut_full_app_screen.dart';

class AuthController extends GetxController {
  Auth authData = Auth();


  login() async {

    print(authData.login);
    if (authData.login == null || authData.password == null ||
        authData.password!.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Put userId and password",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else {
      try {
        HelperFunction.changeSystemUIColor(
            Colors.transparent, Colors.transparent);

        Dialogue.showLoadingDialog();

        String loginApi = Api.login;

        print(authData.toJson());
        var authLoginApiResp = await ApiPostCalls.postApiResponse(
            loginApi, authData.toJson());

        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);

        if (authLoginApiResp.statusCode == 200) {
          Auth data = Auth.fromJson(jsonDecode(authLoginApiResp.body));

          const storage = FlutterSecureStorage();
          await storage.write(key: 'token', value: data.token);
          await storage.write(key: 'user_id', value: authData.login.toString());

          Get.offAll(const PeanutFullApp());
        }
        else if (authLoginApiResp.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Invalid userId or password",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else if (authLoginApiResp.statusCode == 500) {
          Fluttertoast.showToast(
              msg: "Internal server error",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

      } catch (e) {
        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);

        Fluttertoast.showToast(
            msg: "Check your internet connection.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
  }

}