import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/Servicios/firebase_Service.dart';
import 'package:prueba1/provider.dart';

class Readfabricacion extends StatefulWidget {
  const Readfabricacion({super.key});

  @override
  State<Readfabricacion> createState() => _ReadfabricacionState();
}

class _ReadfabricacionState extends State<Readfabricacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(title: const Text('Fabricaciones'),
      actions: [
        IconButton(onPressed: (){
          context.read<FabNum>().fabchange(value1: 0);
        }, 
        
        icon: const Icon(Icons.arrow_back_ios))
      
      ],),
      
      
      
      body: 
      FutureBuilder(
        future: getFabs(),
        builder: ((context, snapshot) {
          if (snapshot.hasData){return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data?[index]['ID']),
                onTap: ((){
                  // entrar a su menu
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