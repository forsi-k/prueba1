import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:prueba1/Constantes/constantes.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  final scrollController = ScrollController();
  double dayWidth = 30;
  bool showDaysRow = true;
  bool showStickyArea = true;
  List<GanttRelativeEvent> events = [];

  @override
  void initState() {
    super.initState();
    fetchBobinas();
  }

  Future<void> fetchBobinas() async {
    try {
      QuerySnapshot fabricacionesSnapshot =
          await FirebaseFirestore.instance.collection('fabricaciones').get();
      Map<String, List<GanttRelativeEvent>> tempMachineEvents = {};

      for (var fabricacionDoc in fabricacionesSnapshot.docs) {
        if (kDebugMode) {
          print("Fabricacion Doc ID: ${fabricacionDoc.id}");
        }

        QuerySnapshot bobinasSnapshot =
            await fabricacionDoc.reference.collection('bobinas').get();
        if (kDebugMode) {
          print(
              "Número de bobinas encontradas: ${bobinasSnapshot.docs.length}");
        }

        for (var bobinaDoc in bobinasSnapshot.docs) {
          var data = bobinaDoc.data() as Map<String, dynamic>;
          if (kDebugMode) {
            print("Bobina Data: $data");
          }

          // Verificar y convertir los datos adecuadamente
          String? inicioStr =
              data['Inicio'] is String ? data['Inicio'] as String : null;
          String? finalStr =
              data['Final'] is String ? data['Final'] as String : null;
          dynamic maquinaData = data['maquina'];
          String? np = data['np'] is String ? data['np'] as String : null;

          if (inicioStr == null || finalStr == null || np == null) {
            if (kDebugMode) {
              print("Error: Datos faltantes o incorrectos en el documento.");
            }
            continue;
          }

          DateTime startDate;
          DateTime endDate;

          try {
            startDate = DateTime.parse(inicioStr);
            endDate = DateTime.parse(finalStr);
          } catch (e) {
            if (kDebugMode) {
              print("Error al parsear fechas: $e");
            }
            continue;
          }

          String maquina;
          if (maquinaData is int) {
            maquina = maquinaData.toString();
          } else if (maquinaData is String) {
            maquina = maquinaData;
          } else {
            if (kDebugMode) {
              print(
                  "Error: El campo 'maquina' tiene un tipo de dato inesperado.");
            }
            continue;
          }

          GanttRelativeEvent event = GanttRelativeEvent(
            relativeToStart:
                Duration(days: startDate.difference(DateTime.now()).inDays),
            duration: Duration(days: endDate.difference(startDate).inDays),
            suggestedColor: Colors.blue, // Cambia según necesites
            displayName: np,
          );

          if (tempMachineEvents.containsKey(maquina)) {
            tempMachineEvents[maquina]!.add(event);
          } else {
            tempMachineEvents[maquina] = [event];
          }
        }
      }

      List<GanttRelativeEvent> allEvents = [];
      tempMachineEvents.forEach((maquina, eventsForMachine) {
        allEvents.addAll(eventsForMachine);
      });

      setState(() {
        events = allEvents;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error al recuperar datos: $e");
      }
    }
  }

  void onZoomIn() {
    setState(() {
      dayWidth += 5;
    });
  }

  void onZoomOut() {
    if (dayWidth <= 10) return;
    setState(() {
      dayWidth -= 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        // ignore: deprecated_member_use
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          if (scrollController.offset <
              scrollController.position.maxScrollExtent) {
            scrollController.jumpTo(scrollController.offset + 50);
          }
        }
        // ignore: deprecated_member_use
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          if (scrollController.offset >
              scrollController.position.minScrollExtent) {
            scrollController.jumpTo(scrollController.offset - 50);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Planificación bobinado')),
          backgroundColor: colorAppbar,
          actions: [
            IconButton(
              onPressed: onZoomIn,
              icon: const Icon(Icons.zoom_in),
            ),
            IconButton(
              onPressed: onZoomOut,
              icon: const Icon(Icons.zoom_out),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              SizedBox(
                height: 500, // Ajusta según necesites
                child: GanttChartView(
                  scrollPhysics: const BouncingScrollPhysics(),
                  stickyAreaWeekBuilder: (context) {
                    return const Center(
                      child: Text(
                        'Bobinadoras',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                  stickyAreaDayBuilder: (context) {
                    return AnimatedBuilder(
                      animation: scrollController,
                      builder: (context, _) {
                        final pos = scrollController.positions.firstOrNull;
                        final currentOffset = pos?.pixels ?? 0;
                        final maxOffset =
                            pos?.maxScrollExtent ?? double.infinity;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: currentOffset > 0
                                  ? () {
                                      scrollController
                                          .jumpTo(scrollController.offset - 50);
                                    }
                                  : null,
                              color: Colors.white,
                              icon: const Icon(Icons.arrow_left, size: 28),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: currentOffset < maxOffset
                                  ? () {
                                      scrollController
                                          .jumpTo(scrollController.offset + 50);
                                    }
                                  : null,
                              color: Colors.white,
                              icon: const Icon(Icons.arrow_right, size: 28),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  scrollController: scrollController,
                  maxDuration: null,
                  startDate: DateTime.now(),
                  dayWidth: dayWidth,
                  eventHeight: 40,
                  stickyAreaWidth: 200,
                  showStickyArea: showStickyArea,
                  showDays: showDaysRow,
                  weekEnds: const {WeekDay.sunday},
                  startOfTheWeek: WeekDay.monday,
                  events: events,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
