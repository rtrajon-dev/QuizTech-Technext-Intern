import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loginsignup/services/api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  bool _isLoading = false;
  bool _isInitialized = false;
  Future<void>? _logoutTimer;

  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _token != null;
  bool get isInitialized => _isInitialized;

  final storage = FlutterSecureStorage();

  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user => _user;


  AuthProvider() {
    loadToken();
  }

  //Log in function
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.login(email, password);

      if (response.containsKey('token') && response['token'] != null) {
        _token = response['token'];

        await fetchUserProfile();
        await storage.write(key: 'token', value: _token);
        print("token stored to local storage");

        _startAutoLogoutTimer(_token!);
      } else if (response.containsKey('message')) {
        // Throw the API message so UI can show it
        throw Exception(response['message']);
      } else {
        throw Exception("Unknown login error");
      }
    } catch (e) {
      // Re-throw the exception directly for UI
      throw e;
    } finally {
      _isLoading = false;
      final secureToken = await storage.read(key: 'token');
      print("secure token is: $secureToken");
      notifyListeners();
    }
  }

  //Load token from local storage
  Future<void> loadToken() async {
    // final prefs = await SharedPreferences.getInstance();
    // final storedToken = prefs.getString('token');
    final storedToken = await storage.read(key: 'token');

    if (storedToken != null) {
      bool isExpired = JwtDecoder.isExpired(storedToken);
      if(isExpired) {
        // await prefs.remove('token');
        await storage.delete(key: 'token');
        _token = null;
      } else {
        _token = storedToken;
        _startAutoLogoutTimer(_token!);

        await fetchUserProfile();

        Duration remaining = JwtDecoder.getRemainingTime((storedToken));
        print("Token valid for: ${remaining.inMinutes} minutes");
      }
    }
    _isInitialized = true;
    notifyListeners();
  }



  //Logout
  Future<void> logout() async {

    try {
      if (_token != null) {
        await ApiService.logout(_token!);
        print("logout done by api");
      }
    } catch (e) {
      print("Warning: Logout failed: $e");
    } finally {
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.remove('token');
      await storage.delete(key: 'token');
      _token = null;
      print("Token removed from local");
      print("Token is now: $_token");
      notifyListeners();
    }
  }

  //Fetch user profile
  Future<void> fetchUserProfile() async {
    try {
      if (_token != null) {
        _user = await ApiService.fetchUser(_token!);
        print("fetch user done by api");
        notifyListeners();
      }
    } catch (e){
      print("Warning: Fetch user failed");
    }
  }


  void _startAutoLogoutTimer(String token){
    final remainingTime = JwtDecoder.getRemainingTime(token);
    _logoutTimer = Future.delayed(remainingTime, () async {
      await logout();
    });
  }
}