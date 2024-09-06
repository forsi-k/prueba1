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
        backgroundColor: colorAppbar,
      ),
      body: FutureBuilder(
          future: getBobs(arguments['uid']),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: colorCajas,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: colorPrimario, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(snapshot.data?[index]['np']),
                      trailing: IconButton(
                        onPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            '/editbob',
                            arguments: {
                              "uid": arguments['uid'],
                              "uuid": snapshot.data?[index]['uuid'],
                              "meta": snapshot.data?[index]['meta'],
                              "np": snapshot.data?[index]['np'],
                              "maquina": snapshot.data?[index]['maquina']
                            },
                          );
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 750),
                              content: Text(
                                "Actualizada correctamente",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        hoverColor: colorPrimario,
                      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, "/addbob",
              arguments: {"uid": arguments['uid']});
          setState(() {});
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 750),
              content: Text(
                "Creada correctamente",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        backgroundColor: colorPrimario,
        child: const Icon(
          Icons.add,
          color: colorFondo,
        ),
      ),
    );
  }
}
