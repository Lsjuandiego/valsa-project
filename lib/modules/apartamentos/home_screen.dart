import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import 'apartamentos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulación de usuario (puedes reemplazar esto con la lógica real de usuario)
    const String userName = 'Juan David Valencia Salgado';
    const String userEmail = 'judvalenciasa@gmail.com';

    return Scaffold(
      appBar: AppBar(
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // Espacio adicional arriba
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 3), // Ajuste de espacio entre los textos
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.logout), // Icono de logout junto al texto
                  SizedBox(width: 10), // Espacio entre el icono y el texto
                  Text('Cerrar sesión'),
                ],
              ),
              onTap: () {
                // Navegar al inicio de sesión al presionar "Cerrar sesión"
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false, // Eliminar todas las rutas anteriores
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'lib/assets/images/valsa.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  _buildModuleCard(context,'Apartamentos'),
                  _buildModuleCard(context,'Información de Mantenimientos'),
                  _buildModuleCard(context,'Información de Limpiezas'),
                  _buildModuleCard(context,'Facturas'),
                  _buildModuleCard(context,'Empresas'),
                  _buildModuleCard(context,'Informes'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir una Card para cada módulo
  Widget _buildModuleCard(BuildContext context, String moduleName) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Acciones cuando se selecciona un módulo, si es necesario
          // Por ejemplo, podrías navegar a la pantalla correspondiente
          if (moduleName == 'Apartamentos') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApartamentosScreen()), // Navega a la pantalla de Apartamentos
            );
          }
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              moduleName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}