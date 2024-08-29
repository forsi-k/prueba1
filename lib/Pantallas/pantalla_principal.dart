// esta es la pantalla principal de la app //
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Pantallas/cuerpo.dart';
import 'package:prueba1/Widget/barra_de_navegacion.dart';
import 'package:prueba1/provider.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    Indexnum watch = context.watch<Indexnum>();
    String Menu = "";
    switch (watch.selectindex) {
      case == 0:
        {
          Menu = "Panel de control";
        }

      case == 1:
        {
          Menu = "Fabricaciones";
        }

      case == 2:
        {
          Menu = "Configuraciones";
        }

      case == 3:
        {
          Menu = "Usuario";
        }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(Menu),
      ),
      drawer: const NavBar(),
      body: const SafeArea(
          child: Row(
        children: [
          // cuerpo
          Expanded(
              child: SizedBox(
            child: PanelDeControl(),
          )),
        ],
      )),
    );
  }
}
