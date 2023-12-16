import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/apartamento.dart';
import 'apartamentos_controller.dart';
import 'mock_data.dart';

class ApartamentosScreen extends StatefulWidget {
  @override
  _ApartamentosScreenState createState() => _ApartamentosScreenState();
}

class _ApartamentosScreenState extends State<ApartamentosScreen> {
  final ApartamentosController _apartamentosController =
  ApartamentosController();

  List<Apartamento> _apartamentos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchApartamentos();
  }

  Future<void> fetchApartamentos() async {
    try {
      final token = await getToken();
      final apartamentos =
      await _apartamentosController.fetchApartamentos(token);
      setState(() {
        _apartamentos = apartamentos;
        _isLoading = false;
      });
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> getToken() async {
    if (kIsWeb) {
      final localStorage = LocalStorage('my_web_storage');
      await localStorage.ready;

      final token = localStorage.getItem('token');
      print('este es el token: $token');
      return token ?? '';
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('token') ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área de Apartamentos'),
      ),
      body: _isLoading
          ? const Center(
        child: SpinKitFadingCube(
          color: Colors.blue,
          size: 50.0,
        ),
      )
          : ListView.builder(
        itemCount: _apartamentos.length,
        itemBuilder: (context, index) {
          final apartamento = _apartamentos[index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(apartamento.nombreApartamento),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Empresa: ${getEmpresaName(apartamento.empresasId)}'),
                  Text(
                      'Limpieza: \$${apartamento.valorLimpieza.toString()}'),
                ],
              ),
              onTap: () {
                // Acciones al hacer tap en un apartamento
              },
            ),
          );
        },
      ),
    );
  }

  // Método para obtener el nombre de la empresa según su ID
  String getEmpresaName(int empresaId) {
    if (empresasNames.containsKey(empresaId)) {
      return empresasNames[empresaId]!;
    }
    return 'Nombre de Empresa $empresaId';
  }
}
