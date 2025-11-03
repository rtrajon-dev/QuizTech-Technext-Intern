import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api-staging.onesuite.io/api";


  // Login API
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200){
        return data;
      }else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login request error: $e');
    }
  }


  //Logout API
  static Future<void> logout(String token) async {
    final url = Uri.parse('$baseUrl/auth/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        final data = jsonDecode(response.body);
        throw Exception(data['message'] ?? 'Failed to logout');
      }
    } catch (e) {
      throw Exception('Logout request error: $e');
    }
  }

  //Fetch user Profile
  static Future<Map<String, dynamic>> fetchUser(String token) async {
    final url = Uri.parse('$baseUrl/auth/user');

    try {
       final response = await http.get(
         url,
         headers: {
           'Content-Type' : 'application/json',
           'Authorization' : 'Bearer $token',
         }
       ).timeout(const Duration(seconds: 15));

       if (response.statusCode == 200) {
         final data = jsonDecode(response.body);
         print("user data found");
         return data;
       } else {
         final data = jsonDecode(response.body);
         throw Exception(data['message'] ?? 'Failed to fetch user profile');
       }
    } catch (e) {
      throw Exception('Fetch user request error: $e');
    }
  }
}
