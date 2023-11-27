import 'package:flutter/material.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/views/phone/login_view.dart';
import 'package:test1/views/phone/main_view.dart';
import 'package:test1/views/phone/medicine_details_view.dart';
import 'package:test1/views/phone/register_view.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/views/web/web_main_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      mainRoute: (context) => const MainView(),
      medicineDetailsRoute: (context) => const MedicineDetailsView(),
    },
    home: const WebMainView(),
  ));
}
