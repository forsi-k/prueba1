import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prueba1/servicios/fire_base_service.dart';
import 'package:prueba1/servicios/mail.dart';
import 'package:table_calendar/table_calendar.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class MenuBobinas extends StatefulWidget {
  const MenuBobinas({super.key});

  @override
  State<MenuBobinas> createState() => _MenuBobinasState();
}

class _MenuBobinasState extends State<MenuBobinas> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    String progreso;
    String meta = arguments['meta'].toString();

    final np = arguments['np'];

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: db
            .collection("fabricaciones")
            .doc(arguments['uid'])
            .collection("bobinas")
            .doc(arguments['uuid'])
            .snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data?.data();
          if (data == null) {
            return const Text("No hay datos");
          }
          double av = data["progreso"];

          if (av > arguments['meta']) {
            progreso = meta;
          } else {
            progreso = av.toString();
          }

          double percent;
          double oa = av / arguments['meta'];

          CalendarFormat _calendarFormat = CalendarFormat.month;
          DateTime _focusedDay = DateTime.now();
          DateTime? _selectedDay;

          if (oa < 1) {
            percent = oa;
          } else {
            percent = 1;
          }

          double porcentaje = (percent * 100);

          if (oa >= 0.9) {
            if (arguments['alerta'] == 0) {
              enviar(arguments['np'], av, arguments['meta']).then((_) {
                modalerta(arguments['uid'], arguments['uuid']);
              });
            } else {
              DoNothingAction;
            }
          }

          if (oa < 0.9) {
            modalertaon(arguments['uid'], arguments['uuid']);
          }

          final maquina = arguments['maquina'];

          return Scaffold(
            appBar: AppBar(
              title: Text("bobina: $np"),
            ),
            body: Row(
              children: [
                Expanded(
                  // ROW 1
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorCajas),
                                  child: CircularPercentIndicator(
                                    radius: 100,
                                    lineWidth: 10,
                                    percent: percent,
                                    progressColor: colorPrimario,
                                    circularStrokeCap: CircularStrokeCap.square,
                                    center: Text(
                                      "$porcentaje%",
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    footer: const Text(
                                        "porcentaje avance actual",
                                        style: TextStyle(fontSize: 20)),
                                    animation: true,
                                    animationDuration: 1000,
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorCajas),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Center(child: Text("avance actual")),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: Text(
                                      "$progreso / $meta",
                                      style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                              fontSize: 40,
                                              color: colorPrimario)),
                                    ))
                                  ],
                                ),
                              ),
                            ))),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorCajas),
                                  child: Column(
                                    children: [
                                      const Text("maquina:"),
                                      Text(
                                        "$maquina",
                                        style: const TextStyle(
                                            fontSize: 40, color: colorPrimario),
                                      ),
                                      const Text("bobinador: User1")
                                    ],
                                  )),
                            ))),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // ROW 2
                  flex: 2,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 5,
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorCajas),
                                  child: AspectRatio(
                                    aspectRatio: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 32,
                                              ),
                                              Text(
                                                'Avance diario bobina',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Expanded(
                                            child: BarChart(
                                              randomData(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // ROW 3
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorCajas),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorCajas),
                              ),
                            ))),
                        Expanded(
                            flex: 5,
                            child: SizedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: width,
                                  height: height,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorCajas),
                                  child: null),
                            ))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(left: 500),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      await Navigator.pushNamed(context, "/actbob", arguments: {
                        "meta": arguments['meta'],
                        "np": arguments['np'],
                        "uuid": arguments['uuid'],
                        "uid": arguments['uid'],
                        "ID": arguments['ID']
                      },);
                    },
                    heroTag: Null,
                    child: const Icon(Icons.upload),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 500.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, "/avancebob", arguments: {
                          "meta": arguments['meta'],
                          "np": arguments['np'],
                          "uuid": arguments['uuid'],
                          "uid": arguments['uid'],
                          "ID": arguments['ID']
                        });
                      },
                      heroTag: null,
                      child: const Icon(Icons.document_scanner),
                    ),
                  ),
                ],
              ),
            ),
          );
        },);
  }
}

BarChartGroupData makeGroupData(
  int x,
  double y,
) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: colorSeleccion,
        borderRadius: BorderRadius.zero,
        width: 22,
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
      ),
    ],
  );
}

Widget getTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  Widget text = Text(
    days[value.toInt()],
    style: style,
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: text,
  );
}

BarChartData randomData() {
  return BarChartData(
    maxY: 10.0,
    barTouchData: BarTouchData(
      enabled: false,
    ),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getTitles,
          reservedSize: 38,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 30,
          showTitles: true,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
    ),
    barGroups: List.generate(
      7,
      (i) => makeGroupData(
        i,
        Random().nextInt(5).toDouble() + 2,
      ),
    ),
    gridData: const FlGridData(show: false),
  );
}
