import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/Constantes.dart';
import 'package:prueba1/Pantallas/pantallaPrincipal.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TTE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor:colorFondo, // COLOR DEL FONDO DEFINIDO EN CONSTANTES.DART
          brightness: Brightness.dark
        ), 
        home: const PantallaPrincipal(),
    );
  }
}
