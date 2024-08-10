import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/Data%20(tainy)/navBarData.dart';
import 'package:prueba1/provider.dart';
import 'package:provider/provider.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {

  @override
  Widget build(BuildContext context) {
    final data = Navbardata();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20), // agrego espacio entre la parte superior y la lista
      child: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) => Buildmenuentry(data, index),
        ),
    );
  }
  Widget Buildmenuentry(Navbardata data, int index) {
    Indexnum watch = context.watch<Indexnum>();

    final estaSeleccionado = watch.selectindex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5 ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6.0)
        ),
        color: estaSeleccionado ? colorSeleccion : Colors.transparent
      ),
      child: InkWell(
        onTap: () => setState(() {
           context.read<Indexnum>().Indexchange(value1: index);
           
        }),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0), // agrego espacio entre los miembros de los iconos
              child: Icon(
                data.menu[index].icon, 
                color: estaSeleccionado ? Colors.black : Colors.grey,
              ),
            ),
            Text(
              data.menu[index].title,
              style: TextStyle(
                fontSize: 16,
                color: estaSeleccionado ? Colors.black : Colors.grey,
                fontWeight: estaSeleccionado ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

