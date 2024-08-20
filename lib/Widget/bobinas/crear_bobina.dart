import 'package:flutter/material.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class AddBob extends StatefulWidget {
  const AddBob({super.key});

  @override
  State<AddBob> createState() => _AddBobState();
}

class _AddBobState extends State<AddBob> {

  TextEditingController npcontroller = TextEditingController(text: "");
  TextEditingController metacontroller = TextEditingController(text: ""); 
  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    
    return Scaffold(
      appBar: AppBar(title: const Text('nueva bobina'),
      actions: [
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.arrow_back_ios))
      ],),
      
    body: Padding(padding: const EdgeInsets.all(20.0),
    child: Column(children: [
      TextField(
        controller: npcontroller,
        decoration: const InputDecoration(
          hintText: 'ingrese np bobina'
        ),
      ),

      const SizedBox(height: 20.0,),

      TextField(
        controller: metacontroller,
        decoration: const InputDecoration(
          hintText: 'ingrese vueltas totales'
        ),
      ),

      const SizedBox(height: 20.0,),

      ElevatedButton(onPressed: () async{
        await addbob(arguments['uid'], npcontroller.text, int.parse(metacontroller.text)).then((_)async{
            final avance = await avancetot(arguments['uid'], arguments['uuid']);
            db.collection("fabricaciones").doc(arguments['uid']).collection("bobinas").doc(arguments['uuid']).update({
              "progreso": avance
            });
            Navigator.pop(context);
            });
      }, child: const Text("guardar"))
    ],),),
    );
  }
}