import 'package:flutter/material.dart';
import '../login/login_controller.dart';
import '../login/login_screen.dart';
import 'apartamentos_screen.dart';

class HomeScreen extends StatelessWidget {
  final LoginController _loginController = LoginController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loginController.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error al cargar datos'),
            ),
          );
        } else {
          final userName = snapshot.data?['userName'] ?? 'Usuario Ejemplo';
          final userEmail = snapshot.data?['userEmail'] ?? 'usuario@example.com';

          return Scaffold(
            appBar: AppBar(
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      userName,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(
                      userEmail,
                      style: TextStyle(fontSize: 16),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Cerrar sesión'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            body: Center(
              // Tu contenido de la pantalla principal aquí
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(
                      children: [
                        Image.asset(
                          'lib/assets/images/valsa.png',
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            color: Colors.black.withOpacity(0.6),
                            child: const Text(
                              'Secciones',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        _buildModuleCard(context, 'Apartamentos'),
                        _buildModuleCard(context, 'Información de Mantenimientos'),
                        _buildModuleCard(context, 'Información de Limpiezas'),
                        _buildModuleCard(context, 'Facturas'),
                        _buildModuleCard(context, 'Empresas'),
                        _buildModuleCard(context, 'Informes'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Método para construir una Card para cada módulo
  Widget _buildModuleCard(BuildContext context, String moduleName) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          if (moduleName == 'Apartamentos') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApartamentosScreen()),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.5)],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  moduleName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
