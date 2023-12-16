import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/get_storage_instance.dart';
import 'login_service.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<bool> loginUser(String email, String password) async {
    try {
      final result = await _authService.login(email, password);
      if (result['res'] == true) {
        dynamic storage = getStorageInstance();

        if (kIsWeb) {
          await storage.ready;
          await storage.setItem('userName', result['user']['name']);
          await storage.setItem('userEmail', result['user']['email']);
          await storage.setItem('token', result['token']);
        } else {
          SharedPreferences prefs = await storage;
          prefs.setString('userName', result['user']['name']);
          prefs.setString('userEmail', result['user']['email']);
          prefs.setString('token', result['token']);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<Map<String, String>> getUserData() async {
    dynamic storage = getStorageInstance();

    if (kIsWeb) {
      await storage.ready;
      final userName = storage.getItem('userName') ?? 'Usuario Ejemplo';
      final userEmail = storage.getItem('userEmail') ?? 'usuario@example.com';
      return {'userName': userName, 'userEmail': userEmail};
    } else {
      SharedPreferences prefs = await storage;
      final userName = prefs.getString('userName') ?? 'Usuario Ejemplo';
      final userEmail = prefs.getString('userEmail') ?? 'usuario@example.com';
      return {'userName': userName, 'userEmail': userEmail};
    }
  }
}