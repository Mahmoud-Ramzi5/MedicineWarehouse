import 'dart:convert';
import 'package:http/http.dart' as http;

class WebApi {
  static final uri = Uri.parse('http://10.0.2.2:8000/api/register');

  WebApi();

  Future<bool> login(String username, String password) async {
    var response = await http.post(
      uri,
      encoding: const Utf8Codec(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "/",
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
}
