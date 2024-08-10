import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider.dart';

class EditFabricacion extends StatefulWidget {
  const EditFabricacion({super.key});

  @override
  State<EditFabricacion> createState() => _EditFabricacionState();
}

class _EditFabricacionState extends State<EditFabricacion> {

TextEditingController idController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Editar fabricacion'),
      actions: [
        IconButton(onPressed: (){
          context.read<FabNum>().fabchange(value1: 0);
        }, 
        
        icon: const Icon(Icons.arrow_back_ios))
      
      ],), 


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
             
              //await updatefabs("", idController.text);
            },
             child: const Text("actualizar"))
          ],
        ),
      ),
    );
  }
}