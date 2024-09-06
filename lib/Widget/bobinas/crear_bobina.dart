import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
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
  DateTime endDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: const Text('nueva bobina'),
        backgroundColor: colorAppbar,
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
              decoration: const InputDecoration(
                hintText: 'ingrese np bobina',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'np fabricacion',
                labelStyle: TextStyle(color: colorPrimario),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: colorPrimario, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: metacontroller,
              decoration: const InputDecoration(
                hintText: 'ingrese vueltas totales',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'vueltas totales',
                labelStyle: TextStyle(color: colorPrimario),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: colorPrimario, width: 2, style: BorderStyle.solid),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: maquinacontroller,
              decoration: const InputDecoration(
                hintText: 'Ingrese maquina en la que la fabricara',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorPrimario, width: 2),
                ),
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                labelText: 'maquina',
                labelStyle: TextStyle(color: colorPrimario),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: colorPrimario, width: 2, style: BorderStyle.solid),
                ),
              ),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimario,
                      foregroundColor: colorFondo),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            primaryColor:
                                colorPrimario, // Color de fondo del header
                            hintColor:
                                colorPrimario, // Color de acento en botones
                            colorScheme: const ColorScheme.dark(
                              primary: colorPrimario, // Color de los botones
                              onPrimary:
                                  colorSecundario, // Color del texto de los botones
                              onSurface:
                                  colorSecundario, // Color del texto de los días
                            ),
                            buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme
                                  .primary, // Color del texto de los botones
                            ),
                            dialogBackgroundColor:
                                colorCajas, // Fondo del cuadro de diálogo
                          ),
                          child: child!,
                        );
                      },
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorPrimario,
                      foregroundColor: colorFondo),
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            primaryColor:
                                colorPrimario, // Color de fondo del header
                            hintColor:
                                colorPrimario, // Color de acento en botones
                            colorScheme: const ColorScheme.dark(
                              primary: colorPrimario, // Color de los botones
                              onPrimary:
                                  colorSecundario, // Color del texto de los botones
                              onSurface:
                                  colorSecundario, // Color del texto de los días
                            ),
                            buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme
                                  .primary, // Color del texto de los botones
                            ),
                            dialogBackgroundColor:
                                colorCajas, // Fondo del cuadro de diálogo
                          ),
                          child: child!,
                        );
                      },
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorPrimario,
                    foregroundColor: colorFondo),
                onPressed: () async {
                  await addbob(
                    arguments['uid'],
                    npcontroller.text,
                    int.parse(metacontroller.text),
                    int.parse(maquinacontroller.text),
                    startDate,
                    endDate,
                  ).then((_) async {
                    // ignore: use_build_context_synchronously
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
