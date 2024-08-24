// esta es la pantalla principal de la app //
import 'package:flutter/material.dart';
import 'package:prueba1/Pantallas/cuerpo.dart';
import 'package:prueba1/Widget/barra_de_navegacion.dart';


class PantallaPrincipal extends StatelessWidget{
  const PantallaPrincipal({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bienvenido"),),
      drawer: const NavBar(),
      body: const SafeArea(
        child: Row(
          children: [
            // cuerpo
            Expanded(
              child: SizedBox(
                child: PanelDeControl(),
              )
              ),
          ],
       ) 
      ),
    );
  }
}