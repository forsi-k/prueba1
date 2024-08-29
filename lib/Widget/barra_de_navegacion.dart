import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/Data%20(tainy)/navbardata.dart';
import 'package:prueba1/provider.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final data = Navbardata();

    return Drawer(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 10, bottom: 10, top: 10),
        child: ListView.builder(
          itemCount: data.menu.length,
          itemBuilder: (context, index) => buildmenuentry(data, index),
        ),
      ),
    );
  }

  Widget buildmenuentry(Navbardata data, int index) {
    Indexnum watch = context.watch<Indexnum>();

    final estaSeleccionado = watch.selectindex == index;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: estaSeleccionado ? colorSeleccion : Colors.transparent),
      child: InkWell(
        onTap: () => setState(() {
          context.read<Indexnum>().indexchange(value1: index);
        }),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                  8.0), // agrego espacio entre los miembros de los iconos
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
                fontWeight:
                    estaSeleccionado ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
