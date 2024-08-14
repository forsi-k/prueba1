import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider.dart';

class MenuFabricaciones extends StatefulWidget {
  const MenuFabricaciones({super.key});

  @override
  State<MenuFabricaciones> createState() => _MenuFabricacionesState();
}

class _MenuFabricacionesState extends State<MenuFabricaciones> {
  

  @override
  Widget build(BuildContext context) {


    return 
    
    Column(children: [

      
const SizedBox(height: 20.0,),
      ElevatedButton(
        onPressed: (){
    
    context.read<FabNum>().fabchange(value1: 1);

        }, 
      child: const Text("Ver fabricaciones")),

const SizedBox(height: 20.0,),
      ElevatedButton(
        onPressed: (){
          
           context.read<FabNum>().fabchange(value1: 2);

        }, 
      child: const Text("Editar fabricaciones")),

const SizedBox(height: 20.0,),
      ElevatedButton(
        onPressed: (){
          
 context.read<FabNum>().fabchange(value1: 3);

        }, 
      child: const Text("Nueva fabricacion")),
    ],

    );
  }
}