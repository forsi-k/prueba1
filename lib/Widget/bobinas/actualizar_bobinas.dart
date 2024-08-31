import 'package:flutter/material.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

 void dropdowncallback(String? selectedvalue){
  if (selectedvalue is String) {
    
  }
 }
class ActualizarBobinas extends StatefulWidget {
  const ActualizarBobinas({super.key});

  @override
  State<ActualizarBobinas> createState() => _ActualizarBobinasState();
}

class _ActualizarBobinasState extends State<ActualizarBobinas> {
  TextEditingController avancecontroller = TextEditingController(text: "");
  String dropdownvalue = 'Turno mañana';    
  
  var items = [     
    'Turno mañana', 
    'Turno tarde', 
    'Turno noche',  
  ];

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('cargar avance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: avancecontroller,
              decoration: const InputDecoration(
                  hintText: 'ingrese avance que se realizo el dia de hoy'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            DropdownButton( 
                
              value: dropdownvalue, 
                
              icon: const Icon(Icons.keyboard_arrow_down),     

              items: items.map((String items) { 
                return DropdownMenuItem( 
                  value: items, 
                  child: Text(items), 
                ); 
              }).toList(), 

              onChanged: (String? newValue) {  
                setState(() { 
                  dropdownvalue = newValue!; },); },),
            const SizedBox(
              height: 20.0,
              ),
            ElevatedButton(
                onPressed: () async {
                  await updatebobs(
                          arguments['uid'],
                          arguments['uuid'],
                          double.parse(avancecontroller.text),
                          arguments['meta'],
                          arguments['np'],
                          dropdownvalue
                          )
                      .then((_) async {
                    final avance =
                        await avancetot(arguments['uid'], arguments['uuid']);
                    db
                        .collection("fabricaciones")
                        .doc(arguments['uid'])
                        .collection("bobinas")
                        .doc(arguments['uuid'])
                        .update({"progreso": avance});

                    Navigator.pop(context);
                  });
                },
                child: const Text("cargar"))
          ],
        ),
      ),
    );
  }
}
