import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/Constantes.dart';
import 'package:prueba1/Pantallas/pantalla_principal.dart';

import 'package:prueba1/servicios/fire_base_service.dart';
import 'package:provider/provider.dart';
import '../provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController legajo = TextEditingController(text: "");
  TextEditingController pass = TextEditingController(text: "");

  checkInicio() async {
    try {
      bool entro = false;
      CollectionReference ref = db.collection("users");
      QuerySnapshot user = await ref.get();
      if (user.docs.isNotEmpty) {
        for (var cursor in user.docs) {
          try {
            if (cursor.get("legajo") == legajo.text) {
              entro = true;
              if (cursor.get("pass") == pass.text) {
                String nombre = cursor.get("Nombre");
                // ignore: use_build_context_synchronously
                Provider.of<UserProvider>(context, listen: false)
                    .setUserId(legajo.text);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(microseconds: 500),
                    content: Text(
                      "Bienvenido $nombre",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
                Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PantallaPrincipal()));
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    duration: Duration(microseconds: 500),
                    content: Text(
                      "Contraseña incorrecta",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            } else if (entro == false) {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(microseconds: 500),
                  content: Text(
                    "Legajo incorrecto",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          } catch (e) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                duration: Duration(seconds: 2),
                content: Text(
                  "Hubo un problema",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Container(
            alignment: Alignment.center,
            height: 225,
            width: 600,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colorCajas,
                boxShadow: [
                  BoxShadow(
                    color: colorPrimario.withOpacity(0.2),
                    spreadRadius: 40,
                    blurRadius: 50,
                  )
                ]),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: legajo,
                    style: const TextStyle(color: colorPrimario),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimario, width: 2),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: false,
                      labelText: 'User',
                      labelStyle: TextStyle(color: colorPrimario),
                      hintText: 'Legajo',
                      hintStyle: TextStyle(color: colorPrimario),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: colorPrimario,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: pass,
                    style: const TextStyle(color: colorPrimario),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorPrimario, width: 2),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: false,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: colorPrimario),
                      hintText: 'Ingrese su contraseña',
                      hintStyle: TextStyle(color: colorPrimario),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: colorPrimario,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimario,
                      foregroundColor: colorFondo),
                  onPressed: checkInicio,
                  child: const Text(
                    "Ingresar",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "V 0.1",
                  style: TextStyle(
                      color: colorPrimario, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
