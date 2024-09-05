// esta es la pantalla principal de la app //
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Pantallas/cuerpo.dart';
import 'package:prueba1/Widget/UI/barra_de_navegacion.dart';
import 'package:prueba1/provider.dart';

class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    Indexnum watch = context.watch<Indexnum>();
    String menu = "";
    switch (watch.selectindex) {
      case == 0:
        {
          menu = "Panel de control";
        }

      case == 1:
        {
          menu = "Fabricaciones";
        }

      case == 2:
        {
          menu = "Planificación";
        }

      case == 3:
        {
          menu = "Configuración";
        }

      case == 4:
        {
          menu = "Usuario";
        }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(menu),
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
