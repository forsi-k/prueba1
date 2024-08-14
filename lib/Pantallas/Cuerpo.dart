import 'package:flutter/material.dart';
import 'package:prueba1/Widget/fabricaciones.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/buscador.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/new_fabricacion.dart';
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
    FabNum ver = context.watch<FabNum>();

    switch(watch.selectindex) {
      
      case == 0: {
       return Container(color: const Color.fromARGB(255, 255, 59, 167),);
        
      }
      
     
      case == 1: {

        switch(ver.fabnum) {

          case == 0: {
            return const MenuFabricaciones();
          }

          case == 1: {
            return const Readfabricacion();
          }

          case == 2: {
            return const Buscador();
          }

          case == 3: {
            return const AddFabricacion();
          }

          
          
          
          default: {
           return const Text("error");
        
          }
        }
        
      }
      
      
      case ==2: {
        return Container(color: const Color.fromARGB(255, 72, 59, 255),);
        
      }

      case ==3: {
        return Container(color: const Color.fromARGB(255, 59, 216, 255),);
        
      }

      case ==4: {
        return Container(color: const Color.fromARGB(255, 255, 147, 59),);
        
      }
     

      default: {
        return const Text("error");
        
      }
      
}

}
}