// lib/pantallas/menu_pantalla.dart
import 'package:flutter/material.dart';
import 'consulta_pais_pantalla.dart';

class MenuPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consulta de Países en flutter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const  Text(
              'Seleccione el tipo de consulta que desea realizar:',
              style: TextStyle(fontSize: 20),
            ),
            const  SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultaPaisPantalla(tipoConsulta: 'nombre'),
                  ),
                );
              },
              child: const Text("Consultar por Nombre de País "),
            ),
             const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsultaPaisPantalla(tipoConsulta: 'codigo'),
                  ),
                );
              },
              child: const Text("Consultar por Código de País"),
            ),
          ],
        ),
      ),
    );
  }
}
