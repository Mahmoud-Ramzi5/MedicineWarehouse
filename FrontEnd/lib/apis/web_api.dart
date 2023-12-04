import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:test1/classes/category.dart' as CC;

class WebApi {
  static final loginUri = Uri.parse('');
  static final addMedicineUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/new_medicine');
  static final fetchCategoriesUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/categories');

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
      String enCommercialName,
      String arCommercialName,
      String enScientificName,
      String arScientificName,
      String enManufactureCompany,
      String arManufactureCompany,
      String expiryDate,
      double price,
      int quantityAvailable,
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
      "category_ids": categoryIds.join(','),
      'image_path': imageName,
      'image': MultipartFile.fromBytes(image, filename: imageName),
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

  Future<List<CC.Category>> fetchCategories() async {
    final response = await dio.getUri(
      fetchCategoriesUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
    );
    if (response.statusCode == 200) {
      List<CC.Category> categoryList = [];
      for (var category in response.data['message']) {
        final categoryMap =
            CC.Category.fromJson(category as Map<String, dynamic>);
        categoryList.add(categoryMap);
      }
      return categoryList;
    } else {
      throw Exception('Failed to load Medicines');
    }
  }

  Future<void> GG(int userId, List<int> medicines) async {
    final formData =
        FormData.fromMap({"user_id": userId, "medicines": medicines});
    var response = await dio.postUri(Uri.parse('http://127.0.0.1:8000/api/GG'),
        data: formData,
        options: Options(headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        }));
    print(response.data);
  }
}
