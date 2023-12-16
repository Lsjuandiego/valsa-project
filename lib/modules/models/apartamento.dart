class Apartamento {
  final int id;
  final int empresasId;
  final String nombreApartamento;
  final int valorLimpieza;

  Apartamento({
    required this.id,
    required this.empresasId,
    required this.nombreApartamento,
    required this.valorLimpieza,
  });

  factory Apartamento.fromJson(Map<String, dynamic> json) {
    return Apartamento(
      id: json['id'] as int,
      empresasId: json['empresas_id'] as int,
      nombreApartamento: json['nombre_apartamento'] as String,
      valorLimpieza: json['valor_limpieza'] as int,
    );
  }
}
