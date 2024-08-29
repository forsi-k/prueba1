import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController legajo = TextEditingController(text: "");
  TextEditingController pass = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Legajo"),
          TextField(
            controller: legajo,
            decoration: const InputDecoration(
                hintText: 'ingrese avance que se realizo el dia de hoy'),
          ),
          Text("Legajo"),
          TextField(
            controller: pass,
            decoration: const InputDecoration(
                hintText: 'ingrese avance que se realizo el dia de hoy'),
          ),
        ],
      ),
    );
  }
}
