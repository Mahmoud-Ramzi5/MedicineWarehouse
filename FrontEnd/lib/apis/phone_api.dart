import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test1/classes/medicine.dart';

class Api {
  static final registerUri =
      Uri.parse('http://10.0.2.2:8000/api/users/register');
  static final loginUri = Uri.parse('http://10.0.2.2:8000/api/users/login');
  static final logoutUri = Uri.parse('http://10.0.2.2:8000/api/users/logout');
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

  Future<List<dynamic>> fetchMedicine() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/users/medicines'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> medicineList = [];
      for (var medicine in body['data']) {
        final medicineMap = Medicine.fromJson(medicine as Map<String, dynamic>);
        medicineList.add(medicineMap);
      }

      return medicineList;
    } else {
      throw Exception('Failed to load Medicines');
    }
  }
}
