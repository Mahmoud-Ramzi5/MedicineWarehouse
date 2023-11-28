import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class WebApi {
  static final loginUri = Uri.parse('');
  static final addMedicineUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/new_medicine');

  WebApi();

  Future<bool> login(String username, String password) async {
    var response = await http.post(
      loginUri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(
        {
          "username": username,
          "password": password,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> addMedicine(
      String expiryDate,
      int quantityAvailable,
      int price,
      String enCommercialName,
      String arCommercialName,
      String enScientificName,
      String arScientificName,
      String enManufactureCompany,
      String arManufactureCompany,
      List<int> categoryIds,
      Uint8List image) async {
    var response = await http.post(
      addMedicineUri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(
        {
          "expiry_date": expiryDate,
          "quantity_available": quantityAvailable,
          "price": price,
          "en_commercial_name": enCommercialName,
          "ar_commercial_name": arCommercialName,
          "en_scientific_name": enScientificName,
          "ar_scientific_name": arScientificName,
          "en_manufacture_company": enManufactureCompany,
          "ar_manufacture_company": arManufactureCompany,
          "category_id": categoryIds,
          //"image": image
        },
      ),
    );
    print(image.toList());
    print(response.body);
  }
}
