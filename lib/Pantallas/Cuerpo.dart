import 'package:flutter/material.dart';
import 'package:prueba1/Pantallas/Turnero.dart';
import 'package:prueba1/Pantallas/profile.dart';
import 'package:prueba1/Widget/Planificacion/planificacion_1.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/read_fabricacion.dart';
import 'package:prueba1/provider.dart';
import 'package:provider/provider.dart';

class PanelDeControl extends StatefulWidget {
  const PanelDeControl({super.key});

  @override
  State<PanelDeControl> createState() => _PanelDeControlState();
}

class _PanelDeControlState extends State<PanelDeControl> {
  @override
  Widget build(BuildContext context) {
    
    Indexnum watch = context.watch<Indexnum>();

    switch (watch.selectindex) {
      case == 0:
        {
          return const Text("Pantalla en creacion selecciona 'FABRICACIONES'");
        }

      case == 1:
        {
          return const Readfabricacion();
        }

      case == 2:
        {
          return const Planning();
        }

      case == 3:
        {
          return const Turnero();
        }

      case == 4:
        {
          return const Profile();
        }

        case == 5:
        {
          return const Profile();
        }

      default:
        {
          return const Text("error");
        }
    }
  }
}
