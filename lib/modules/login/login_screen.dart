import 'package:flutter/material.dart';
import 'login_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = LoginController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/assets/images/valsa.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Por favor, introduce un correo válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // Activar animación de carga
                  });

                  String email = emailController.text;
                  String password = passwordController.text;

                  bool loggedIn =
                  await _loginController.loginUser(email, password);
                  setState(() {
                    _isLoading = false; // Detener animación de carga
                  });

                  if (loggedIn) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Credenciales no válidas'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Iniciar sesión'),
              ),
              _isLoading
                  ? const Padding(
                padding: EdgeInsets.all(20),
                child: SpinKitFadingCube(
                  color: Colors.blue,
                  size: 50.0,
                ),
              )
                  : SizedBox(), // Mostrar animación de carga si _isLoading es true
            ],
          ),
        ),
      ),
    );
  }
}
