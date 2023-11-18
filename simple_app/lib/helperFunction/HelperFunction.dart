import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:http/http.dart' as http;


class HelperFunction{
  static Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
    }
  }

  static void changeSystemUIColor(Color navigationBarColor, Color barColor){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: navigationBarColor,
      statusBarColor: barColor,
    ));
  }

  static formatDate(DateTime dateTime) {
    // Format the DateTime object into "dd-MM-yyyy hh:mm:ss a" format
    String formattedDateTime = "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}-${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')} ${dateTime.hour < 12 ? 'AM' : 'PM'}";

    return formattedDateTime;
  }


}