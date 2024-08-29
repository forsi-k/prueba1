import 'package:cloud_firestore/cloud_firestore.dart';
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
      CollectionReference ref = db.collection("users");
      QuerySnapshot user = await ref.get();
      if (user.docs.isNotEmpty) {
        for (var cursor in user.docs) {
          if (cursor.get("legajo") == legajo.text) {
            if (cursor.get("pass") == pass.text) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUserId(legajo.text);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PantallaPrincipal()));
            } else {}
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
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
              SizedBox(
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
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  controller: pass,
                  decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      filled: true,
                      labelText: 'Password',
                      hintText: 'Ingrese su contraseña',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              ElevatedButton(onPressed: checkInicio, child: Text("Ingresar"))
            ],
          ),
        ),
      ),
    );
  }
}
