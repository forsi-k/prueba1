import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';
import 'package:prueba1/servicios/mail.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class MenuBobinas extends StatefulWidget {
  const MenuBobinas({super.key});

  @override
  State<MenuBobinas> createState() => _MenuBobinasState();
}

class _MenuBobinasState extends State<MenuBobinas> {

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    String progreso;
    String meta= arguments['meta'].toString();
    
    if (arguments['progreso'] > arguments['meta']) {
      progreso = meta;
    }
    else {
      progreso = arguments['progreso'].toString();
    }
    
    double percent;
    double oa = arguments['progreso']/arguments['meta'];
   
    if (oa < 1) {
      percent = oa;
    }
    else {
      percent = 1;
    }

    if (oa >= 0.9) {
          if (arguments['alerta'] == 0) {
            enviar(arguments['np'], arguments['progreso'], arguments['meta']).then((_){
              modalerta(arguments['uid'], arguments['uuid']);
            });
          }
          else {
            DoNothingAction;
          }
        }
    
    if (oa < 0.9) {
      modalertaon(arguments['uid'], arguments['uuid']);
    }
    
    return Scaffold(

      appBar:AppBar(title: const Text("bobina"),
      ),
      
      body: Row(
        children: [
          Column(
            children: [
              flex
              Expanded(child: SizedBox(
                child: ,
              ))
          
            
              Text("vueltas totales: $meta"),
              const SizedBox(height: 20.0,),
              Center(child: CircularPercentIndicator(
                radius: 50,
                lineWidth: 10,
                percent: percent,
                progressColor: colorPrimario,
                circularStrokeCap: CircularStrokeCap.square,
                center: Text('$progreso%', style: const TextStyle(fontSize: 10),),
                footer: const Text("avance actual"),
                animation: true,
                animationDuration: 1000,
                ),),
              
            ],
          
          ),
        ],
      ),
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: (){
                    Navigator.pushNamed(context, "/actbob",arguments: {
                      "meta": arguments['meta'],
                      "np": arguments['np'],
                      "uuid": arguments['uuid'],
                      "uid": arguments['uid'],
                      "ID": arguments['ID']
                    });
                  },
          heroTag: Null,
          child: const Icon(Icons.upload),),
          
          Expanded(child: Container()),
      
          FloatingActionButton(onPressed: (){
            Navigator.pushNamed(context, "/avancebob",arguments: {
              "meta": arguments['meta'],
              "np": arguments['np'],
              "uuid": arguments['uuid'],
              "uid": arguments['uid'],
              "ID": arguments['ID']
      
            });
          },
          heroTag: null,
          child: const Icon(Icons.document_scanner),),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FloatingActionButton(onPressed: () async{
              final avance = await avancetot(arguments['uid'], arguments['uuid']);
              db.collection("fabricaciones").doc(arguments['uid']).collection("bobinas").doc(arguments['uuid']).update({
                "progreso": avance
            });  
            },
            heroTag: null,
            child: const Icon(Icons.replay_outlined),),
          )
        ],
      ),
    ),  
    );
  }
}
