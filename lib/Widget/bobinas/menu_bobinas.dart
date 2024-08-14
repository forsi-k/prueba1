import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:prueba1/Constantes/constantes.dart';


class MenuBobinas extends StatefulWidget {
  const MenuBobinas({super.key});

  @override
  State<MenuBobinas> createState() => _MenuBobinasState();
}

class _MenuBobinasState extends State<MenuBobinas> {

  


  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    String porcentaje = ((arguments['progreso']/arguments['meta'])*100).toString();
    
    String progreso = arguments['progreso'].toString();
    String meta= arguments['meta'].toString();

    return Scaffold(

      appBar:AppBar(title: const Text('bobina'),
      ),
      
      body: Column(
        children: [
          Text("vueltas totales: $progreso"),
          const SizedBox(height: 20.0,),
          Text("vueltas totales: $meta"),
          const SizedBox(height: 20.0,),
          Center(child: CircularPercentIndicator(
            radius: 50,
            lineWidth: 10,
            percent: (arguments['progreso']/arguments['meta']),
            progressColor: colorPrimario,
            circularStrokeCap: CircularStrokeCap.square,
            center: Text('$porcentaje%', style: const TextStyle(fontSize: 20),),
            footer: const Text("avance actaul"),
            animation: true,

            ),),
        ],
      
      
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.pushNamed(context, "/actbob",arguments: {
                "meta": arguments['meta'],
                "np": arguments['np'],
                "uuid": arguments['uuid'],
                "uid": arguments['uid'],
                "ID": arguments['ID']
              });
            },
            child: const Icon(Icons.upload),),  
    );
  }
}