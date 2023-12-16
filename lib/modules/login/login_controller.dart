import 'package:shared_preferences/shared_preferences.dart';

import 'login_service.dart';

class LoginController {
  final AuthService _authService = AuthService();

  Future<bool> loginUser(String email, String password) async {
    try {
      final result = await _authService.login(email, password);
      if (result['res'] == true) {
        // Guardar datos del usuario en SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userName', result['user']['name']);
        prefs.setString('userEmail', result['user']['email']);

        return true; // Credenciales válidas, se permite el acceso
      } else {
        return false; // Credenciales inválidas
      }
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
      return false; // Credenciales inválidas por error de conexión u otro motivo
    }
  }

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userName = prefs.getString('userName') ?? 'Usuario Ejemplo';
    final String userEmail = prefs.getString('userEmail') ?? 'usuario@example.com';
    return {'userName': userName, 'userEmail': userEmail};
  }
}
