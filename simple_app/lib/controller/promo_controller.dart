import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../helperFunction/HelperFunction.dart';
import '../models/Promo.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

import '../views/Dialogue.dart';

class PromoController extends GetxController {
  RxList<Promo> promoArray = <Promo>[].obs;


  fetchData([bool showLoader = false]) async {
    await Future.delayed(Duration.zero);

    promoArray.clear();

    try {
      var envelope = '''
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://tempuri.org/">
  <soapenv:Header/>
  <soapenv:Body>
    <web:GetCCPromo>
      <web:lang>en</web:lang>
    </web:GetCCPromo>
  </soapenv:Body>
</soapenv:Envelope>
''';

      if(showLoader){
        HelperFunction.changeSystemUIColor(
            Colors.transparent, Colors.transparent);

        Dialogue.showLoadingDialog();
      }

      var response = await http.post(
        Uri.parse('https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc'),
        headers: {
          'Content-Type': 'text/xml',
          'SOAPAction': 'http://tempuri.org/CabinetMicroService/GetCCPromo',
        },
        body: envelope,
      );

      if(showLoader){
        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);
      }

      var transformer = Xml2Json();
      transformer.parse(response.body);
      var json = transformer.toParker();

      var data = jsonDecode(json);

      var promoResultString = data['s:Envelope']['s:Body']['GetCCPromoResponse']['GetCCPromoResult'];

      // Replace 'False' with 'false'
      promoResultString = promoResultString.replaceAll('False', 'false');

      var promoResult = jsonDecode(promoResultString);

      promoResult.forEach((key, value) {
        Promo promo = Promo();

        promo.key = key;
        promo.image = value['image'].replaceAll('forex-images.instaforex.com', 'forex-images.ifxdb.com');
        promo.text = value['text'];
        promo.link = value['link'];
        promo.buttonText = value['button_text'];
        promo.buttonColor = value['button_color'];
        promo.euroAvailable = value['euro_available'];
        promo.dieDate = value['die_date'];
        promoArray.add(promo);

      });

    } catch (e) {
      if(showLoader){
        Dialogue.dismissLoadingDialog();
        HelperFunction.changeSystemUIColor(
            Colors.white, Colors.white);
      }

      Fluttertoast.showToast(
          msg: "Please check your internet connection and try again",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}