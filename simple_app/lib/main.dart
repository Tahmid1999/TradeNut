import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:xml2json/xml2json.dart';


import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:simple_app/views/login_screen.dart';
import 'package:simple_app/views/splash_screen.dart';

void main() {
  runApp(
      DevicePreview(
        enabled: false,
        builder: (context) =>  MyApp(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType)
    {
      return GetMaterialApp(
    title: 'TradeNut',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Color(0xff875220),

    ),
    // This is the theme of your application.
    //
    // TRY THIS: Try running your application with "flutter run". You'll see
    // the application has a blue toolbar. Then, without quitting the app,
    // try changing the seedColor in the colorScheme below to Colors.green
    // and then invoke "hot reload" (save your changes or press the "hot
    // reload" button in a Flutter-supported IDE, or press "r" if you used
    // the command line to start the app).
    //
    // Notice that the counter didn't reset back to zero; the application
    // state is not lost during the reload. To reset the state, use hot
    // restart instead.
    //
    // This works for code too, not just values: Most code changes can be
    // tested with just a hot reload.
    //primaryColor: Colors.green

    ),
    home: SplashScreen(
    )
    ,
    );
  }
  );
  }
}




// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Promotional Campaigns',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String soapEndpoint =
//       'https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc?wsdl';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Promotional Campaigns'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             fetchData();
//           },
//           child: Text('Fetch Data'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> fetchData() async {
//     try {
//       var envelope = '''
// <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:web="http://tempuri.org/">
//   <soapenv:Header/>
//   <soapenv:Body>
//     <web:GetCCPromo>
//       <web:lang>en</web:lang>
//     </web:GetCCPromo>
//   </soapenv:Body>
// </soapenv:Envelope>
// ''';
//
//       var response = await http.post(
//         Uri.parse('https://api-forexcopy.contentdatapro.com/Services/CabinetMicroService.svc'),
//         headers: {
//           'Content-Type': 'text/xml',
//           'SOAPAction': 'http://tempuri.org/CabinetMicroService/GetCCPromo',
//         },
//         body: envelope,
//       );
//
//       var transformer = Xml2Json();
//       transformer.parse(response.body);
//       var json = transformer.toParker();
//
//       var data = jsonDecode(json);
//
//       var promoResultString = data['s:Envelope']['s:Body']['GetCCPromoResponse']['GetCCPromoResult'];
//
//       // Replace 'False' with 'false'
//       promoResultString = promoResultString.replaceAll('False', 'false');
//
//       var promoResult = jsonDecode(promoResultString);
//
//       promoResult.forEach((key, value) {
//         print('Key: $key');
//         print('Image: ${value['image']}');
//         print('Text: ${value['text']}');
//         print('Link: ${value['link']}');
//         print('Button Text: ${value['button_text']}');
//         print('Button Color: ${value['button_color']}');
//         print('Euro Available: ${value['euro_available']}');
//         print('Die Date: ${value['die_date']}');
//         print('\n');
//       });
//
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
//
