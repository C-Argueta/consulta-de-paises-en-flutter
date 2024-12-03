// lib/modelos/pais.dart
class Pais {
  final String nombre;
  final String capital;
  final List<String> idiomas;
  final String bandera;
  final int poblacion;

  Pais({
    required this.nombre,
    required this.capital,
    required this.idiomas,
    required this.bandera,
    required this.poblacion,
  });

  factory Pais.fromJson(Map<String, dynamic> json) {
    return Pais(
      nombre: json['name']['common'],
      capital: json['capital'] != null ? json['capital'][0] : 'No disponible',
      idiomas: json['languages'] != null
          ? List<String>.from(json['languages'].values)
          : ['No disponible'],
      bandera: json['flags']['png'],
      poblacion: json['population'],
    );
  }
}
