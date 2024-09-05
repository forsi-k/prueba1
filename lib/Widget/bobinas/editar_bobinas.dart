import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class EditBobinas extends StatefulWidget {
  const EditBobinas({super.key});

  @override
  State<EditBobinas> createState() => _EditBobinasState();
}

class _EditBobinasState extends State<EditBobinas> {
  TextEditingController npcontroller = TextEditingController(text: "");
  TextEditingController metacontroller = TextEditingController(text: "");
  TextEditingController maquinacontroller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    npcontroller.text = arguments['np'];
    metacontroller.text = arguments['meta'].toString();
    maquinacontroller.text = arguments['maquina'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Bobinas'),
        backgroundColor: colorAppbar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: npcontroller,
              decoration: const InputDecoration(
                hintText: 'ingrese np bobinas',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'np bobina',
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
            TextField(
              controller: metacontroller,
              decoration: const InputDecoration(
                hintText: 'ingrese vueltas totales',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'vueltas totales',
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
            TextField(
              controller: maquinacontroller,
              decoration: const InputDecoration(
                hintText: 'ingrese meta de vueltas',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'meta',
                labelStyle: TextStyle(color: colorPrimario),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: colorPrimario, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimario, foregroundColor: colorFondo),
              onPressed: () async {
                updbob(
                        arguments['uid'],
                        arguments['uuid'],
                        npcontroller.text,
                        int.parse(metacontroller.text),
                        int.parse(maquinacontroller.text))
                    .then(
                  (_)
                  // ignore: use_build_context_synchronously
                  {
                    Navigator.pop(context);
                  },
                );
              },
              child: const Text(
                "Actualizar",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: colorFondo),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    delbob(arguments['uid'], arguments['uuid']).then(
                      (_) {
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Borrar fabricacion",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
