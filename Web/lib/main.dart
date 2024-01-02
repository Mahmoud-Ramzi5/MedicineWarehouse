import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseweb/constants/routes.dart';
import 'package:warehouseweb/views/web/web_login_view.dart';
import 'package:warehouseweb/views/web/web_main_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routes: {
        webMainViewRoute: (context) => const WebMainView(),
      },
      locale: Get.deviceLocale,
      home: const WebLoginView(),
    );
  }
}
