import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiPostCalls{

  ApiPostCalls();
  static String? bearerToken;

  static postApiResponse(String apiUrl, var map, [bool setBearerToken = false]) async {


    if(setBearerToken == true) {
      const storage = FlutterSecureStorage();
      bearerToken = await storage.read(key: 'token');
    }

    print(apiUrl);
    try {

      if(setBearerToken == true){
        final response = await http.post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $bearerToken',
            },
            body: jsonEncode(map)
        );

        print('Response status: ${response.statusCode}');
        print('Response data: ${response.body}');

        return response;

      }
      else{
        final response = await http.post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(map)
        );

        print('Response data: ${response.body}');

        return response;


      }



    } catch (e) {
      print('Request failed with error: $e');


    }
  }
}