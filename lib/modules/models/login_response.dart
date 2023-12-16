import 'package:valsa/modules/models/usuario.dart';

class LoginResponse {
  final bool res;
  final String token;
  final User user;

  LoginResponse({
    required this.res,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      res: json['res'] as bool,
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}


