import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
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

  final dio = Dio();

  Future<dynamic> addMedicine(
      String expiryDate,
      int quantityAvailable,
      double price,
      String enCommercialName,
      String arCommercialName,
      String enScientificName,
      String arScientificName,
      String enManufactureCompany,
      String arManufactureCompany,
      List<int> categoryIds,
      Uint8List image,
      String imageName) async {
    final formData = FormData.fromMap({
      "expiry_date": expiryDate,
      "quantity_available": quantityAvailable,
      "price": price,
      "en_commercial_name": enCommercialName,
      "ar_commercial_name": arCommercialName,
      "en_scientific_name": enScientificName,
      "ar_scientific_name": arScientificName,
      "en_manufacture_company": enManufactureCompany,
      "ar_manufacture_company": arManufactureCompany,
      "category_ids": categoryIds,
      'image': imageName,
      //MultipartFile.fromBytes(image, filename: imageName),
    });
    var response = await dio.postUri(addMedicineUri,
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        }));
    return response;
  }
}
