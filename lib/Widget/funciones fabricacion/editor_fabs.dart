import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_Service.dart';

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
      appBar: AppBar(
        title: const Text('Editar fabricacion'), // titulo de appbar
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
                hintText: 'Ingrese nueva ID fabricacion',
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
                  backgroundColor: colorPrimario, foregroundColor: colorFondo),
              onPressed: () async {
                await updatefabs(arguments['uid'], idController.text).then((_) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Actualizar",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: colorFondo),
              ),
            ),
            Flexible(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    String uid = arguments['uid'];
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return BorrarDefF(
                            uids: uid,
                          );
                        }).then((_) {
                      Navigator.pop(context);
                    });
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

class BorrarDefF extends StatefulWidget {
  final String uids;
  const BorrarDefF({super.key, required this.uids});

  @override
  State<BorrarDefF> createState() => _BorrarDefFState();
}

class _BorrarDefFState extends State<BorrarDefF> {
  @override
  Widget build(BuildContext context) {
    String uid = widget.uids;
    return Container(
        child: ElevatedButton(
      onPressed: () {
        deletefabs(uid).then(
          (_) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        );
      },
      child: Text("Confimar"),
    ));
  }
}
