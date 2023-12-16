import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apartamento.dart';

class ApartamentosService {
  static const String baseUrl = 'http://backendvalsa.test/api';

  Future<List<Apartamento>> fetchApartamentos(String token) async {
    final url = Uri.parse('$baseUrl/apartamento');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['data'];
        List<Apartamento> apartamentos = data
            .map((apartamentoJson) => Apartamento.fromJson(apartamentoJson))
            .toList();
        return apartamentos;
      } else {
        throw Exception('Failed to load apartamentos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
