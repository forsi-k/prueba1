import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/provider.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class ReadBobinas extends StatefulWidget {
  const ReadBobinas({super.key});

  @override
  State<ReadBobinas> createState() => _ReadBobinasState();
}

class _ReadBobinasState extends State<ReadBobinas> {

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(

      appBar:AppBar(title: const Text('bobinas'),
      ),
      
      
      
      body: 
      FutureBuilder(
        future: getBobs(arguments['uid']),
        builder: ((context, snapshot) {
          if (snapshot.hasData){return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?[index]['ID']),
                onTap: ((){
                    
                }),
              );
            },
          );} else {
            return const Center(
              child:CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(colorSeleccion),)
              
              );
          }
          
        }))

      
    );
  }
}