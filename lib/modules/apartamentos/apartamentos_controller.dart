import '../models/apartamento.dart';
import 'apartamentos_service.dart';

class ApartamentosController {
  final ApartamentosService _apartamentosService = ApartamentosService();

  Future<List<Apartamento>> fetchApartamentos(String token) async {
    try {
      final apartamentos =
      await _apartamentosService.fetchApartamentos(token);
      return apartamentos;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}