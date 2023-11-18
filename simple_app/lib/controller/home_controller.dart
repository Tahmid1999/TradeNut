import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../api/api.dart';
import '../api/api_post_calls.dart';
import '../helperFunction/HelperFunction.dart';
import '../models/Auth.dart';
import '../models/OpenTrades.dart';
import '../views/Dialogue.dart';
import '../views/login_screen.dart';

class HomeController extends GetxController {

  RxString totalProfit = "".obs;
  RxList<OpenTrades> tradeArray = <OpenTrades>[].obs;

  Auth authData = Auth();



  getData([bool showLoader = false]) async {
    await Future.delayed(Duration.zero);

    totalProfit.value = "0.0";
    tradeArray.value = [];

    if(showLoader){
      HelperFunction.changeSystemUIColor(
          Colors.transparent, Colors.transparent);

      Dialogue.showLoadingDialog();
    }
    const storage = FlutterSecureStorage();
    String? userIdString = await storage.read(key: 'user_id');

    int? userId = int.tryParse(userIdString ?? '');


    authData.login = userId;
    authData.token = await storage.read(key: 'token');


    try {
      var accountInfoApiResp = await ApiPostCalls.postApiResponse(
          Api.openTrades, authData.toJson(), true);

      if (showLoader) {
        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);
      }

      if (accountInfoApiResp.statusCode == 200) {
        var openTradesApiRsp = jsonDecode(accountInfoApiResp.body);

        double totalProfitDouble = 0.0;
        List<OpenTrades> openTrades = [];

        for (var item in openTradesApiRsp) {
          totalProfitDouble += item['profit'];
          openTrades.add(OpenTrades.fromJson(item));
        }

        tradeArray.value = openTrades;
        totalProfit.value = totalProfitDouble.toString();
      }
      else {
        Fluttertoast.showToast(
            msg: "Please login again. Something went wrong.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        await storage.deleteAll();
        Get.offAll(const LoginScreen());
      }
    }
    catch (e) {
      if (showLoader) {
        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);
      }
      Fluttertoast.showToast(
          msg: "Please check your internet connection.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
  }

}