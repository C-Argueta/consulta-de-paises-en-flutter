
import 'package:ejercicio1examen/src/constantes/api_constans.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modelos/pais.dart';

class ConsultaPaisPantalla extends StatefulWidget {
  final String tipoConsulta;

  ConsultaPaisPantalla({required this.tipoConsulta});

  @override
  _ConsultaPaisPantallaState createState() => _ConsultaPaisPantallaState();
}

class _ConsultaPaisPantallaState extends State<ConsultaPaisPantalla> {
  final TextEditingController _controller = TextEditingController();
  Pais? pais;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> consultarPais() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    final query = _controller.text.trim();
    if (query.isEmpty) return;

    final url = widget.tipoConsulta == 'nombre'
        ? Uri.parse('${ApiConstants.baseUrl}${ApiConstants.byName}$query')
        : Uri.parse('${ApiConstants.baseUrl}${ApiConstants.byAlpha}$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          pais = Pais.fromJson(data[0]);
        });
      } else {
        setState(() {
          errorMessage = 'Error: No se pudo obtener la información.';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: Hubo un problema con la conexión.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipoConsulta == 'nombre' ? 'Consultar por Nombre' : 'Consultar por Código'),
      ),
      body: SingleChildScrollView(  // Aquí se agrega el SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: widget.tipoConsulta == 'nombre' ? 'Nombre del País' : 'Código del País',
                border: const OutlineInputBorder(),
              ),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: consultarPais,
              child: isLoading ? CircularProgressIndicator() : const Text('Realizar consulta'),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
            if (pais != null && errorMessage.isEmpty) ...[
              Image.network(pais!.bandera),
              const SizedBox(height: 10),
              Text('Nombre: ${pais!.nombre}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Capital: ${pais!.capital}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Población: ${pais!.poblacion}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text('Idiomas: ${pais!.idiomas.join(", ")}', style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}

