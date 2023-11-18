import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:simple_app/views/login_screen.dart';

import '../api/api.dart';
import '../api/api_post_calls.dart';
import '../helperFunction/HelperFunction.dart';
import '../models/AccountInformation.dart';
import '../models/Auth.dart';
import '../views/Dialogue.dart';

class ProfileController extends GetxController {
  RxString name = "".obs;
  RxString address = "".obs;
  RxDouble balance = 0.0.obs;
  RxString city = "".obs;
  RxString country = "".obs;
  RxInt currency = 0.obs;
  RxInt currentTradesCount = 0.obs;
  RxDouble currentTradesVolume = 0.0.obs;
  RxDouble equity = 0.0.obs;
  RxDouble freeMargin = 0.0.obs;
  RxBool isAnyOpenTrades = false.obs;
  RxBool isSwapFree = false.obs;
  RxInt leverage = 0.obs;
  RxString phone = "".obs;
  RxInt totalTradesCount = 0.obs;
  RxDouble totalTradesVolume = 0.0.obs;
  RxInt type = 0.obs;
  RxInt verificationLevel = 0.obs;
  RxString zipCode = "".obs;

  Auth authData = Auth();

  getAccountInformation() async{

    const storage = FlutterSecureStorage();
    String? userIdString = await storage.read(key: 'user_id');

    int? userId = int.tryParse(userIdString ?? '');


    authData.login = userId;
    authData.token = await storage.read(key: 'token');

    HelperFunction.changeSystemUIColor(
        Colors.transparent, Colors.transparent);

    Dialogue.showLoadingDialog();

    try {
      var accountInfoApiResp = await ApiPostCalls.postApiResponse(
          Api.accountInfo, authData.toJson(), true);

      Dialogue.dismissLoadingDialog();
      HelperFunction.changeSystemUIColor(
          Colors.white, Colors.white);

      if (accountInfoApiResp.statusCode == 200) {
        AccountInformation data = AccountInformation.fromJson(
            jsonDecode(accountInfoApiResp.body));

        name.value = data.name ?? "";
        address.value = data.address ?? "";
        balance.value = data.balance ?? 0.0;
        city.value = data.city ?? "";
        country.value = data.country ?? "";
        currency.value = data.currency ?? 0;
        currentTradesCount.value = data.currentTradesCount ?? 0;
        currentTradesVolume.value = data.currentTradesVolume ?? 0.0;
        equity.value = data.equity ?? 0.0;
        freeMargin.value = data.freeMargin ?? 0.0;
        isAnyOpenTrades.value = data.isAnyOpenTrades ?? false;
        isSwapFree.value = data.isSwapFree ?? false;
        leverage.value = data.leverage ?? 0;
        totalTradesCount.value = data.totalTradesCount ?? 0;
        totalTradesVolume.value = data.totalTradesVolume ?? 0.0;
        type.value = data.type ?? 0;
        verificationLevel.value = data.verificationLevel ?? 0;
        zipCode.value = data.zipCode ?? "";

        getPhoneNumber();
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
    catch(e) {
      Dialogue.dismissLoadingDialog();
      HelperFunction.changeSystemUIColor(
          Colors.white, Colors.white);

      Fluttertoast.showToast(
          msg: "Please check your internet connection. Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  getPhoneNumber() async {
    const storage = FlutterSecureStorage();
    String? userIdString = await storage.read(key: 'user_id');

    int? userId = int.tryParse(userIdString ?? '');

    authData.login = userId;
    authData.token = await storage.read(key: 'token');

    HelperFunction.changeSystemUIColor(
        Colors.transparent, Colors.transparent);

    Dialogue.showLoadingDialog();

    try {
      var accountPhnNumApiResp = await ApiPostCalls.postApiResponse(
          Api.phoneNumber, authData.toJson(), true);

      Dialogue.dismissLoadingDialog();
      HelperFunction.changeSystemUIColor(
          Colors.white, Colors.white);

      if (accountPhnNumApiResp.statusCode == 200) {
        String? data = accountPhnNumApiResp.body;

        if (data != null) data = data.replaceAll('"', '').trim();

        phone.value = data ?? "";
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
    catch(e) {
      Dialogue.dismissLoadingDialog();
      HelperFunction.changeSystemUIColor(
          Colors.white, Colors.white);

      Fluttertoast.showToast(
          msg: "Please check your internet connection. Something went wrong.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

  }
}