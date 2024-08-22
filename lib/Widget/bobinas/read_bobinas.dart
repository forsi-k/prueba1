import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';
import 'package:prueba1/servicios/mail.dart';

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
                title: Text(snapshot.data?[index]['np']),
                onTap: (()async{
                   switch(await alerta(arguments['uid'], arguments['uuid'])){


      case == 0: {
        if (arguments['progreso']/arguments['meta'] >= 0.9) {
          enviar(arguments['np'], arguments['progreso'], arguments['meta']).then((_) {
            modalerta(arguments['uid'], arguments['uuid']);
          });
        }
      }

      case == 1: {
        DoNothingAction;
      }

    }
                    Navigator.pushNamed(context, "/mbob", arguments: {
                      "alerta": snapshot.data?[index]['alerta'],
                      "uuid": snapshot.data?[index]['uuid'],
                      "uid": arguments['uid'],
                      "np": snapshot.data?[index]['np'], 
                      "progreso": snapshot.data?[index]['progreso'],
                      "meta": snapshot.data?[index]['meta']
                    });
            }));
            },
          );} else {
            return const Center(
              child:CircularProgressIndicator( valueColor:AlwaysStoppedAnimation<Color>(colorSeleccion),)
              
              );
          }
          
        })),

        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, "/addbob",arguments: {
            "uid": arguments['uid']
          });
        },
        child: const Icon(Icons.add),),

      
    );
  }
}
