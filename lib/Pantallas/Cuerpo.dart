import 'package:flutter/material.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/read_fabricacion.dart';
import 'package:prueba1/provider.dart';
import 'package:provider/provider.dart';

class PanelDeControl extends StatefulWidget {
  const PanelDeControl({super.key});
  
  @override
  State<PanelDeControl> createState() => _PanelDeControlState();
}

class _PanelDeControlState extends State<PanelDeControl> {
  
  @override
  Widget build(BuildContext context) {

    Indexnum watch = context.watch<Indexnum>();

    switch(watch.selectindex) {
      
      case == 0: {
       return const Text("Pantalla en creacion selecciona 'FABRICACIONES'");
        
      }
      
     
      case == 1: {

       return const Readfabricacion();
        
      }
      
      
      case ==2: {
        return const Text("Pantalla en creacion selecciona 'FABRICACIONES'");
        
      }

      case ==3: {
        return const Text("Pantalla en creacion selecciona 'FABRICACIONES'");
        
      }

      case ==4: {
        return const Text("Pantalla en creacion selecciona 'FABRICACIONES'") ;
        
      }
     

      default: {
        return const Text("error");
        
      }
      
}

}
}