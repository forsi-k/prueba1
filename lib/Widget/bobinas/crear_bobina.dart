import 'package:flutter/material.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class AddBob extends StatefulWidget {
  const AddBob({super.key});

  @override
  State<AddBob> createState() => _AddBobState();
}

class _AddBobState extends State<AddBob> {
  TextEditingController npcontroller = TextEditingController(text: "");
  TextEditingController metacontroller = TextEditingController(text: "");
  TextEditingController maquinacontroller = TextEditingController(text: "");
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('nueva bobina'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: npcontroller,
              decoration: const InputDecoration(hintText: 'ingrese np bobina'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: metacontroller,
              decoration:
                  const InputDecoration(hintText: 'ingrese vueltas totales'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: maquinacontroller,
              decoration: const InputDecoration(
                  hintText: 'ingrese en la bobinadora que se realizara'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Fecha de inicio: ${startDate.toLocal().toString().split(' ')[0]}"),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null && selectedDate != startDate) {
                      setState(() {
                        startDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('Seleccionar'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "Fecha final: ${endDate.toLocal().toString().split(' ')[0]}"),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate:
                          startDate, // Para evitar seleccionar una fecha anterior a la fecha de inicio
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null && selectedDate != endDate) {
                      setState(() {
                        endDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('Seleccionar'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () async {
                  await addbob(
                    arguments['uid'],
                    npcontroller.text,
                    int.parse(metacontroller.text),
                    int.parse(maquinacontroller.text),
                    startDate,
                    endDate,
                  ).then((_) async {
                    Navigator.pop(context);
                  });
                },
                child: const Text("Crear"))
          ],
        ),
      ),
    );
  }
}
