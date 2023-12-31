import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:test1/classes/category.dart' as CC;
import 'package:test1/classes/medicine.dart';
import 'package:test1/classes/reports.dart';
import 'dart:typed_data';
import 'package:test1/classes/web_order.dart';

class WebApi {
  static final loginUri = Uri.parse('http://127.0.0.1:8000/api/admin/login');
  static final addMedicineUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/new_medicine');
  static final fetchCategoriesUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/categories');
  static final fetchMedicineWebUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/medicines');
  static final fetchordersUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/orders');
  static final searchUri = Uri.parse('http://127.0.0.1:8000/api/admin/search');
  static final updateorderUri =
      Uri.parse('http://127.0.0.1:8000/api/admin/update_order');
  static final reportsuri =
      Uri.parse('http://127.0.0.1:8000/api/admin/reports');

  WebApi();

  Future<dynamic> login(
    String userName,
    String password,
  ) async {
    var response = await http.post(
      loginUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(
        {
          "userName": userName,
          "password": password,
        },
      ),
    );
    const storage = FlutterSecureStorage();
    final body = json.decode(response.body);
    final token = body['access_token'];
    await storage.write(key: 'Bearer Token', value: token);
    return response;
  }

  static final dio = Dio();

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

  Future<dynamic> orderstauts(int id, String status, bool isPaid) async {
    final response = await dio.postUri(
      updateorderUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
      data: ({"id": id, "status": status, "is_paid": isPaid}),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception("Error");
    }
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

  Future<List<Medicine>> fetchMedicineWeb() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchMedicineWebUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    if (response.statusCode == 200) {
      List<Medicine> medicineList = [];
      for (var medicine in response.data['data']) {
        final medicineMap = Medicine.fromJson(medicine as Map<String, dynamic>);
        medicineList.add(medicineMap);
      }
      return medicineList;
    } else {
      throw Exception('Failed to load Medicines');
    }
  }

  Future<List<WebOrder>> fetchweborders() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchordersUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    if (response.statusCode == 200) {
      List<WebOrder> weborderslist = [];
      for (var weborder in response.data['message']) {
        final webordersmap =
            WebOrder.fromJson(weborder as Map<String, dynamic>);
        weborderslist.add(webordersmap);
      }
      return weborderslist;
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  Future<List<Medicine>> search(String name) async {
    final response = await dio.postUri(
      searchUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
      data: ({"name": name}),
    );
    if (response.statusCode == 200) {
      List<Medicine> medicineList = [];
      for (var medicine in response.data['message']) {
        final medicineMap = Medicine.fromJson(medicine as Map<String, dynamic>);
        medicineList.add(medicineMap);
      }
      return medicineList;
    } else {
      throw Exception('No Medicines');
    }
  }

  Future<Reports> fetchReports(String firstDate, String lastDate) async {
    final response = await dio.postUri(
      reportsuri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      ),
      data: ({"start_date": firstDate, "end_date": lastDate}),
    );
    if (response.statusCode == 200) {
      Reports report = Reports.fromJson(response.data["message"]);
      return report;
    } else {
      throw Exception("Error");
    }
  }
}
