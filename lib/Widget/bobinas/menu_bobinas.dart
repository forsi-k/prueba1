import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/provider.dart';

class MenuBobinas extends StatefulWidget {
  const MenuBobinas({super.key});

  @override
  State<MenuBobinas> createState() => _MenuBobinasState();
}

class _MenuBobinasState extends State<MenuBobinas> {

  


  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
   
    context.read<Bobmeta>().bobmchange(value1: arguments['meta'] );
    context.read<Bobprogress>().bobpchange(value1: arguments['progreso']);

   

    Bobmeta watch = context.watch<Bobmeta>();
    Bobprogress ver = context.watch<Bobprogress>();

    double porcentaje = (ver.bobprogress/watch.bobmeta);

    return Scaffold(
      
      body: Center(child: CircularPercentIndicator(
        radius: 200,
        lineWidth: 20,
        percent: (ver.bobprogress/watch.bobmeta),
        progressColor: colorPrimario,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text("as"),
        ),),
    );
  }
}