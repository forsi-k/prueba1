import 'package:flutter/material.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class EditBobinas extends StatefulWidget {
  const EditBobinas({super.key});

  @override
  State<EditBobinas> createState() => _EditBobinasState();
}

class _EditBobinasState extends State<EditBobinas> {
  TextEditingController npcontroller = TextEditingController(text: "");
  TextEditingController metacontroller= TextEditingController(text: "");
  TextEditingController maquinacontroller= TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    npcontroller.text = arguments['np'];
    metacontroller.text = arguments['meta'].toString();
    maquinacontroller.text = arguments['maquina'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Bobinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: npcontroller,
              decoration: const InputDecoration(
                hintText: 'Ingrese nuevo nombre bobina',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: metacontroller,
              decoration: const InputDecoration(
                hintText: 'Ingrese nueva meta',
              ),
            ),
             const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: maquinacontroller,
              decoration: const InputDecoration(
                hintText: 'Ingrese maquina',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                updbob(arguments['uid'], arguments['uuid'], npcontroller.text, int.parse(metacontroller.text) , int.parse(maquinacontroller.text)).then((_)
                 // ignore: use_build_context_synchronously
                 { Navigator.pop(context);},
                );
              },
              child: const Text(
                "actualizar",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                delbob(arguments['uid'], arguments['uuid']).then((_){
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text("Borrar fabricacion",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}