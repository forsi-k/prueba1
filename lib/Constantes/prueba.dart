import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';

class Prueba extends StatefulWidget {
  const Prueba({super.key});

  @override
  State<Prueba> createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("orueba"),),
      body: Container(color: Colors.red,),
    );
  }
}