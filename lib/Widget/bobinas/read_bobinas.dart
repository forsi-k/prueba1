import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class ReadBobinas extends StatefulWidget {
  const ReadBobinas({super.key});

  @override
  State<ReadBobinas> createState() => _ReadBobinasState();
}

class _ReadBobinasState extends State<ReadBobinas> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('bobinas'),
      ),
      body: FutureBuilder(
          future: getBobs(arguments['uid']),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data?[index]['np']),
                    trailing: IconButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/editbob',
                              arguments: {
                                "uid": arguments['uid'],
                                "uuid": snapshot.data?[index]['uuid'],
                                "meta": snapshot.data?[index]['meta'],
                                "np": snapshot.data?[index]['np'],
                                "maquina": snapshot.data?[index]['maquina']
                              });
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit)),
                    onTap: (() {
                      Navigator.pushNamed(context, "/mbob", arguments: {
                        "alerta": snapshot.data?[index]['alerta'],
                        "uuid": snapshot.data?[index]['uuid'],
                        "uid": arguments['uid'],
                        "np": snapshot.data?[index]['np'],
                        "progreso": snapshot.data?[index]['progreso'],
                        "meta": snapshot.data?[index]['meta'],
                        "maquina": snapshot.data?[index]['maquina']
                      });
                    }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/addbob",
              arguments: {"uid": arguments['uid']});
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
