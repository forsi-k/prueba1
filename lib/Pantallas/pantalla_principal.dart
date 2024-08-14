// esta es la pantalla principal de la app //
import 'package:flutter/material.dart';
import 'package:prueba1/Pantallas/cuerpo.dart';
import 'package:prueba1/Widget/barra_de_navegacion.dart';


class PantallaPrincipal extends StatelessWidget{
  const PantallaPrincipal({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // empiezo a separar los espacios

            // barra de navegacion
            const Expanded(
              flex: 2, // hago que ocupe el 16% de la pantalla 2/12
              child: SizedBox(
                child: NavBar(),
              )
            ),
            // cuerpo
            const Expanded(
              flex: 7, // hago que ocupe el 58% de la pantalla 7/12
              child: SizedBox(
                child: PanelDeControl(),
              )
              ),
            // graficos
             Expanded(
              flex: 3, // hago que ocupe el 25% de la pantalla 7/12
              child: Container(color: Colors.red),
              )
          ],
       ) 
      ),
    );
  }
}