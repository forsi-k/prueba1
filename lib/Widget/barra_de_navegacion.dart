import 'package:flutter/material.dart';
import 'package:prueba1/Constantes/constantes.dart';
import 'package:prueba1/Data%20(tainy)/navBarData.dart';
int selectindex = 0;
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
    final estaSeleccionado = selectindex == index;

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
          selectindex = index;
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

class PanelDeControl extends StatefulWidget {
  const PanelDeControl({super.key});
  
  @override
  State<PanelDeControl> createState() => _PanelDeControlState();
}

class _PanelDeControlState extends State<PanelDeControl> {
  @override
  Widget build(BuildContext context) {
    print(selectindex);
    if(selectindex == 1) {
      return Container(color: Colors.yellow,);
    }
    else {
      return Container(color: Colors.green,);
    } 
}
}