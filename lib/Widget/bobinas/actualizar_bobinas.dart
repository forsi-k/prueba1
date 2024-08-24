import 'package:flutter/material.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class ActualizarBobinas extends StatefulWidget {
  const ActualizarBobinas({super.key});

  @override
  State<ActualizarBobinas> createState() => _ActualizarBobinasState();
}

class _ActualizarBobinasState extends State<ActualizarBobinas> {
 
TextEditingController avancecontroller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {

final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: const Text('cargar avance'),),

      body: Padding(padding: const EdgeInsets.all(20.0),
      child: Column(children: [
TextField(
  keyboardType: TextInputType.number,
  controller: avancecontroller,
  decoration: const InputDecoration(
    hintText: 'ingrese avance actual'
  ),
),

const SizedBox(height: 20.0,),

ElevatedButton(onPressed: () async{
  await updatebobs(arguments['uid'], arguments['uuid'], double.parse(avancecontroller.text), arguments['meta'], arguments['np']).then((_){         
              Navigator.pop(context);
            });
}, 
child: const Text("cargar"))

      ],),
      ),
      );
      }}