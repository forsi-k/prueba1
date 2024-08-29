import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Pantallas/login.dart';

import '../provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  late Future<DocumentSnapshot> _userData;
  @override
  void initState() {
    super.initState();
    final id = Provider.of<UserProvider>(context, listen: false).userId;
    _userData = FirebaseFirestore.instance.collection('users').doc(id).get();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Text('Detalles del usuario'),
            FutureBuilder<DocumentSnapshot>(
                future: _userData,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("error"),
                    );
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(
                      child: Text("No se encontraron los datos"),
                    );
                  }
                  var userData = snapshot.data?.data() as Map<String, dynamic>;
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text("Nombre:"),
                        subtitle: Text(userData["Nombre"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Apellido:"),
                        subtitle: Text(userData["Apellido"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Legajo:"),
                        subtitle: Text(userData["legajo"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Funcion:"),
                        subtitle: Text(userData["Mode"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Maquina actual:"),
                        subtitle: Text(userData["Macact"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Antiguedad:"),
                        subtitle: Text(userData["ant"] ?? "N/A"),
                      ),
                      ListTile(
                        title: Text("Turno actual:"),
                        subtitle: Text(userData["TurnoAct"] ?? "N/A"),
                      )
                    ],
                  );
                }),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Cerrar sesión",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ));
  }
}
