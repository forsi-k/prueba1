import 'package:flutter/material.dart';
import 'package:prueba1/modelos/navbar_modelo.dart';

class Navbardata {
  final menu = const <Navbarmodelo>[
    Navbarmodelo(icon: Icons.home, title: 'Panel de control'),
    Navbarmodelo(icon: Icons.build, title: 'Fabricaciones'),
    Navbarmodelo(icon: Icons.upload, title: 'Cargar datos'),
    Navbarmodelo(icon: Icons.settings, title: 'Configuracion'),
    Navbarmodelo(icon: Icons.person, title: 'Usuario'),
  ];
}
