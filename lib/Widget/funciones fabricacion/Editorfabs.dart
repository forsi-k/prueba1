import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider.dart';
import 'package:prueba1/servicios/firebase_Service.dart';

class EditFabricacion extends StatefulWidget {
  const EditFabricacion({super.key});

  @override
  State<EditFabricacion> createState() => _EditFabricacionState();
}

class _EditFabricacionState extends State<EditFabricacion> {

TextEditingController idController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    idController.text = arguments['ID'];

    return Scaffold(
      appBar:AppBar(title: const Text('Editar fabricacion'),
      ), 


      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Ingrese nueva ID fabricacion',
              ),
            ),

            const SizedBox(height: 20.0,),
            ElevatedButton(onPressed: () async {
               await updatefabs(arguments['uid'], idController.text).then((_){
                Navigator.pop(context);
               });
            },
             child: const Text("actualizar"))
          ],
        ),
      ),
    );
  }
}