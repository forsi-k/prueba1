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

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
    
final np = arguments['np'];

    return Scaffold(

      appBar:AppBar(title: Text("bobina: $np"),
      ),
      
      body: 
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorCajas
                            ),
                           child: CircularPercentIndicator(
                                  radius: 100,
                                  lineWidth: 10,
                                  percent: percent,
                                  progressColor: colorPrimario,
                                  circularStrokeCap: CircularStrokeCap.square,
                                  center: Text('$progreso%', style: const TextStyle(fontSize: 30),),
                                  footer: const Text("porcentaje avance actual", style: TextStyle(fontSize: 20)),
                                  animation: true,
                                  animationDuration: 1000,
                                  ),), ),
                  
                        )
                      ),
                  
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Container()
                      )), 
                              
                    ],
                  
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorCajas 
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                const Center(
                                  child: Text("avance actual")
                                  ),
                                const SizedBox(height: 20,),
                                Center(
                                  child: Text(progreso, style: const TextStyle(fontSize: 60, color: colorPrimario),),
                                )
                              ],
                            ),
                          ),
                        )
                      )),
                  
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorCajas 
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                const Center(
                                  child: Text("meta")
                                  ),
                                const SizedBox(height: 20,),
                                Center(
                                  child: Text(meta, style: const TextStyle(fontSize: 60, color: colorPrimario),),
                                )
                              ],
                            ),
                          ),
                        )
                      )), 
                  
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                        child: Container()
                      )), 
                      
                    ],
                  
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Container(color: Colors.red,)
                      )),
                  
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                        child: Container(color: Colors.yellow,)
                      )), 
                  
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                        child: Container(color: Colors.blue,)
                      )), 
                      
                    ],
                  
                  ),
                ),
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
