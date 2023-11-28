import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';
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
    },
    onGenerateRoute: (settings) {
      if (settings.name == medicineDetailsRoute) {
        final Medicine medicine = settings.arguments as Medicine;
        return MaterialPageRoute(
          builder: (context) {
            return MedicineDetailsView(medicine: medicine);
          },
        );
      }
    },
    home: const WebMainView(),
  ));
}
