import 'package:flutter/material.dart';
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
      // Mock para simular una solicitud asíncrona
      await Future.delayed(Duration(seconds: 2));
      final apartamentos = getApartamentosMockData();
      setState(() {
        _apartamentos = apartamentos;
        _isLoading = false; // Cambia a false cuando se completa la carga
      });
    } catch (e) {
      // Manejo de errores
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área de Apartamentos'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(), // Animación de carga
      )
          : ListView.builder(
        itemCount: _apartamentos.length,
        itemBuilder: (context, index) {
          final apartamento = _apartamentos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(apartamento.nombreApartamento),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Empresa: ${getEmpresaName(apartamento.empresasId)}'),
                  Text('Limpieza: \$${apartamento.valorLimpieza.toString()}'),
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

