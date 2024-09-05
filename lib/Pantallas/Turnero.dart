import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Turnero extends StatefulWidget {
  const Turnero({super.key});

  @override
  State<Turnero> createState() => _TurneroState();
}

class _TurneroState extends State<Turnero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var UserDoc = snapshot.data!.docs[index].data();
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(UserDoc['Apellido']),
                        subtitle: Row(
                          children: [
                            Text(UserDoc['Nombre']),
                            Spacer(),
                            Text(UserDoc['legajo']!),
                            Spacer(),
                            Text(UserDoc['TurnoAct']),
                            Spacer(),
                            Text(UserDoc['Macact']),
                          ],
                        ),
                        onTap: () {
                          String leg = UserDoc['legajo'];
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ModalModificarUser(leg: leg);
                              });
                        },
                      );
                    });
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorSeleccion),
                ));
              }
            }));
  }
}

class ModalModificarUser extends StatefulWidget {
  final String leg;
  ModalModificarUser({required this.leg});

  @override
  State<ModalModificarUser> createState() => _ModalModificarUserState();
}

class _ModalModificarUserState extends State<ModalModificarUser> {
  @override
  String dropdownvalue = 'Turno mañana';
  String dropdownvalue2 = '1';
  var items = [
    'Turno mañana',
    'Turno tarde',
    'Turno noche',
  ];
  var items2 = ['1', '2', '3', '4', '5', '6'];

  Widget build(BuildContext context) {
    String uid = widget.leg;
    return Container(
      padding: const EdgeInsets.all(40),
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Asignar turno:",
            style: TextStyle(color: colorSeleccion, fontSize: 15),
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
              setState(
                () {
                  dropdownvalue = newValue!;
                },
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("Asignar maquina:",
              style: TextStyle(color: colorSeleccion, fontSize: 15)),
          DropdownButton(
            value: dropdownvalue2,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items2.map((String items2) {
              return DropdownMenuItem(
                value: items2,
                child: Text(items2),
              );
            }).toList(),
            onChanged: (String? newValue2) {
              setState(
                () {
                  dropdownvalue2 = newValue2!;
                },
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                updateUsers(dropdownvalue2, dropdownvalue, uid);
                Navigator.pop(context);
              },
              child: const Text("Ingresar"))
        ],
      ),
    );
  }
}
