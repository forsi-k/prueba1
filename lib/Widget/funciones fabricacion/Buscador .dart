import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/Editorfabs.dart';
import 'package:prueba1/provider.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {

  List _resultados = [];
  List _resultlist = [];
  final TextEditingController _SearchController = TextEditingController();

@override
  void initState() {
    _SearchController.addListener(_onSearchChanged);
    super.initState();
  }

_onSearchChanged(){
  print(_SearchController.text);
  searchResultList();
}

searchResultList(){
  var showResults = [];

  if(_SearchController.text != ""){

    for(var clientSnapShot in _resultados )
    {
      var ID = clientSnapShot['ID'].toString().toLowerCase();
      if(ID.contains(_SearchController.text.toLowerCase())){
        showResults.add(clientSnapShot);
      }
    }

  }
  else{
    showResults = List.from(_resultados);
  }

  setState(() {
    _resultlist = showResults;
  });

  searchResultList();
}

  getClientStream() async{
    var data = await FirebaseFirestore.instance.collection('fabricaciones').orderBy('ID').get();
    setState(() {
      _resultados = data.docs;
    });
  }

@override
   void dispose () {
    _SearchController.removeListener(_onSearchChanged);
    _SearchController.dispose();
    super.dispose();
   }

@override
  void didChangeDependencies ( ) {

     getClientStream();

    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CupertinoSearchTextField(
        controller: _SearchController,
      ),
       actions: [
        IconButton(onPressed: (){
          context.read<FabNum>().fabchange(value1: 0);
        }, 
        
        icon: const Icon(Icons.arrow_back_ios))
      
      ]),


      body: 
      
      
      ListView.builder(
        itemCount:  _resultlist.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(_resultlist[index]['ID']),
            onTap: (){
             ;
Navigator.push(context, MaterialPageRoute(builder: (context)=> EditFabricacion()));
            },
          );
        }));
  }
}