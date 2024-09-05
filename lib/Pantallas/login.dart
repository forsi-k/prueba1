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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
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
                    duration: Duration(seconds: 2),
                    content: Text(
                      "Contraseña incorrecta",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            } else if (entro == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  content: Text(
                    "Legajo incorrecto",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          } catch (e) {
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
        child: Container(
          width: 1000,
          height: 230,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: colorCajas),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: legajo,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: true,
                      labelText: 'User',
                      hintText: 'Legajo',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: pass,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: true,
                      labelText: 'Password',
                      hintText: 'Ingrese su contraseña',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  onPressed: checkInicio, child: const Text("Ingresar"))
            ],
          ),
        ),
      ),
    );
  }
}
