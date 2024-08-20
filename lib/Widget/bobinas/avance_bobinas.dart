import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class AvanceBobinas extends StatefulWidget {
  const AvanceBobinas({super.key});

  @override
  State<AvanceBobinas> createState() => _AvanceBobinasState();
}

class _AvanceBobinasState extends State<AvanceBobinas> {

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(

      appBar:AppBar(title: const Text('avance'),
      ),
      
      body:
      FutureBuilder(
        future: avancebob(arguments['uid'], arguments['uuid']),
        builder: ((context, snapshot) {
          if (snapshot.hasData){
            
            return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {

              final avance = snapshot.data?[index]['avancediario'];
              final fecha = snapshot.data?[index]['fecha'];

              return 
              ListTile(
                title: Text("avance: $avance"),
                subtitle: Text("$fecha"),
            );
            },
          );} else {
            return const Center(
              child:CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(colorSeleccion),)
              
              );
          }
          
        })),


      
    );
  }
}
