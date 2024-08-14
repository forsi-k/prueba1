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
    
    return Scaffold(

      appBar:AppBar(title: const Text('bobina'),
      ),
      
      body: Column(
        children: [


          Center(child: CircularPercentIndicator(
            radius: 200,
            lineWidth: 20,
            percent: (arguments['progreso']/arguments['meta']),
            progressColor: colorPrimario,
            circularStrokeCap: CircularStrokeCap.round,
            center: Text('$porcentaje%', style: const TextStyle(fontSize: 50),),
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