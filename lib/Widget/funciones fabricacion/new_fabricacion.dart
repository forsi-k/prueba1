import 'package:flutter/material.dart';
import 'package:prueba1/Servicios/fire_base_Service.dart';

class AddFabricacion extends StatefulWidget {
  const AddFabricacion({super.key});

  @override
  State<AddFabricacion> createState() => _AddFabricacionState();
}

class _AddFabricacionState extends State<AddFabricacion> {
  TextEditingController idController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fabricaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                hintText: 'Ingrese ID fabricacion',
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  await addFabs(idController.text).then((_) {
                    Navigator.pop(context);
                  });
                },
                child: const Text("guardar"))
          ],
        ),
      ),
    );
  }
}
