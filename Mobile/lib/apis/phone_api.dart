import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:test1/classes/cart_item.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/classes/category.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test1/classes/order.dart';

class Api {
  static final registerUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/register');
  static final loginUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/login');
  static final logoutUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/logout');
  static final fetchMedicineUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/medicines');
  static final fetchCategoriesUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/categories');
  static final medicineByCategoryUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/categoryFilter');
  static final orderUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/new_order');
  static final searchUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/search');
  static final fetchOrderUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/orders');
  static final fetchFavoritesUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/favorite');
  static final addToFavoritesUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/addFavorite');
  static final removeFavoritesUri = Uri.parse(
      'https://medicine-warehouse0.000webhostapp.com/api/users/removeFavorite');

  Api();

  Future<dynamic> register(
    int phoneNumber,
    String email,
    String pharmacyName,
    String pharmacyAddress,
    String password,
    String confirmPassword,
  ) async {
    final response = await http.post(
      registerUri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: jsonEncode(
        {
          "phoneNumber": phoneNumber,
          "email": email,
          "pharmacyName": pharmacyName,
          "pharmacyAddress": pharmacyAddress,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      ),
    );
    return response;
  }

  Future<dynamic> login(
    int phoneNumber,
    String password,
    bool rememberMe,
  ) async {
    String rememberMeString;
    if (rememberMe) {
      rememberMeString = "rememberMe";
    } else {
      rememberMeString = "";
    }
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
          "phoneNumber": phoneNumber,
          "password": password,
          "rememberMe": rememberMeString,
        },
      ),
    );
    const storage = FlutterSecureStorage();
    final body = json.decode(response.body);
    final token = body['access_token'];
    await storage.write(key: 'Bearer Token', value: token);
    return response;
  }

  Future<dynamic> logout() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await http.post(
      logoutUri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {},
      ),
    );
    await storage.delete(key: "Bearer Token");
    return response;
  }

  final dio = Dio();

  Future<List<Medicine>> fetchMedicine() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchMedicineUri,
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

  Future<List<Category>> fetchCategories() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchCategoriesUri,
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
      List<Category> categoryList = [];
      for (var category in response.data['message']) {
        final categoryMap = Category.fromJson(category as Map<String, dynamic>);
        categoryList.add(categoryMap);
      }
      return categoryList;
    } else {
      throw Exception('Failed to load Medicines');
    }
  }

  Future<List<Medicine>> fetchMedicineByCategory(int id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.postUri(
      medicineByCategoryUri,
      data: ({"id": id}),
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
      for (var medicine in response.data['message']) {
        final medicineMap = Medicine.fromJson(medicine as Map<String, dynamic>);
        medicineList.add(medicineMap);
      }
      return medicineList;
    } else {
      throw Exception('Failed to load Medicines');
    }
  }

  Future<dynamic> order(List<CartItem> list) async {
    Map<String, dynamic> orderMap = ({});
    for (var cartItem in list) {
      orderMap.addEntries(
          {cartItem.medicine.id.toString(): cartItem.quantity}.entries);
    }
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.postUri(
      orderUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token',
        },
      ),
      data: FormData.fromMap({"medicines": orderMap}),
    );
    return response;
  }

  Future<List<Medicine>> search(String name) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.postUri(
      searchUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token'
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

  Future<List<Order>> fetchOrders() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchOrderUri,
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
      List<Order> ordersList = [];
      for (var order in response.data['message']) {
        final orderMap = Order.fromJson(order as Map<String, dynamic>);
        ordersList.add(orderMap);
      }
      return ordersList;
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  Future<List<Medicine>> fetchFavorites() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.getUri(
      fetchFavoritesUri,
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
      for (var medicine in response.data['message']['medicines']) {
        final medicineMap = Medicine.fromJson(medicine as Map<String, dynamic>);
        medicineList.add(medicineMap);
      }
      return medicineList;
    } else {
      throw Exception('Failed to load Orders');
    }
  }

  Future<dynamic> addToFavorites(int id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.postUri(
      addToFavoritesUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token'
        },
      ),
      data: ({"medicine_id": id}),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('No Medicines');
    }
  }

  Future<dynamic> removeFavorites(int id) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await dio.postUri(
      removeFavoritesUri,
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': "application/json",
          'connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
          'Authorization': 'Bearer $token'
        },
      ),
      data: ({"medicine_id": id}),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('No Medicines');
    }
  }
}
