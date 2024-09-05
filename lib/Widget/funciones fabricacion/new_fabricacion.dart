import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
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
        backgroundColor: colorAppbar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                hintText: 'Ingrese ID fabricacion',
                labelText: 'ID fabricacion',
                labelStyle: TextStyle(color: colorPrimario),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: colorPrimario, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimario,
                    foregroundColor: colorFondo),
                onPressed: () async {
                  await addFabs(idController.text).then((_) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  "Crear",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
