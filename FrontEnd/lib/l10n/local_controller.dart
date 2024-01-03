import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/main.dart';

class MyLocalController extends GetxController {
  Locale initalLang = prefs?.getString("lang") == "en"
      ? const Locale("en")
      : const Locale("ar");

  void changeLang(String lang) {
    Locale locale = Locale(lang);
    prefs?.setString("lang", lang);
    Get.updateLocale(locale);
  }
}
