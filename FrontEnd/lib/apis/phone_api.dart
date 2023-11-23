import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  static final registerUri =
      Uri.parse('http://10.0.2.2:8000/api/users/register');
  static final loginUri = Uri.parse('http://10.0.2.2:8000/api/users/login');
  static final logoutUri = Uri.parse('http://10.0.2.2:8000/api/users/logout');
  Api();

  Future<Map<String, dynamic>> register(
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
        'Accept': "/",
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
    final body = json.decode(response.body);
    return body;
  }

  Future<Map<String, dynamic>> login(
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
        'Accept': "/",
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
    final storage = new FlutterSecureStorage();
    final body = json.decode(response.body);
    final token = body['access_token'];
    await storage.write(key: 'Bearer Token', value: token);
    return body;
  }

  Future<Map<String, dynamic>> logout() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'Bearer Token');
    final response = await http.post(
      logoutUri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "/",
        'connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {},
      ),
    );
    await storage.delete(key: "Bearer Token");
    final body = json.decode(response.body);
    return body;
  }
}
