import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class AvanceBobinas extends StatefulWidget {
  const AvanceBobinas({super.key});

  @override
  State<AvanceBobinas> createState() => _AvanceBobinasState();
}

class _AvanceBobinasState extends State<AvanceBobinas> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('avance'),
      ),
      body: FutureBuilder(
          future: avancebob(arguments['uid'], arguments['uuid']),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final avance = snapshot.data?[index]['avancediario'];
                  final fecha = snapshot.data?[index]['fecha'];
                  final turno = snapshot.data?[index]['Turno'];

                  return ListTile(
                    title: Text("avance: $avance"),
                    subtitle: Row(
                      children: [
                        Text("$fecha"),
                        const SizedBox(width: 20,),
                        Text("$turno")
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await borraravance(arguments['uid'], arguments['uuid'],
                            snapshot.data?[index]['uuuid']);
                        final avance = await avancetot(
                            arguments['uid'], arguments['uuid']);
                        db
                            .collection("fabricaciones")
                            .doc(arguments['uid'])
                            .collection("bobinas")
                            .doc(arguments['uuid'])
                            .update({"progreso": avance});
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorSeleccion),
              ));
            }
          })),
    );
  }
}
