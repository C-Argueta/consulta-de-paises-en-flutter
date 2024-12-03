import 'package:ejercicio1examen/src/pages/menu_pantalla.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPantalla(),
    );
  }
}