import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/Servicios/fire_base_Service.dart';

class Readfabricacion extends StatefulWidget {
  const Readfabricacion({super.key});

  @override
  State<Readfabricacion> createState() => _ReadfabricacionState();
}

class _ReadfabricacionState extends State<Readfabricacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getFabs(),
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
                      title: Text(snapshot.data?[index]['ID']),
                      onTap: (() {
                        Navigator.pushNamed(context, "/bob", arguments: {
                          "ID": snapshot.data?[index]['ID'],
                          "uid": snapshot.data?[index][
                              'uid'] //context.read<FabNum>().fabchange(value1: 4);
                        });
                      }),
                      trailing: IconButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, "/editfab",
                              arguments: {
                                "ID": snapshot.data?[index]['ID'],
                                "uid": snapshot.data?[index]['uid']
                              });
                          setState(() {});
                        },
                        icon: const Icon(Icons.edit),
                        hoverColor: colorPrimario,
                      ),
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
          await Navigator.pushNamed(context, "/newfab");
          setState(() {});
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
