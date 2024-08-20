import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/provider.dart';
import 'package:prueba1/servicios/fire_base_service.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  State<Buscador> createState() => _BuscadorState();
}

class _BuscadorState extends State<Buscador> {

  List _resultados = [];
  List _resultlist = [];
  final TextEditingController _searchcontroller = TextEditingController();

@override
  void initState() {
    _searchcontroller.addListener(_onSearchChanged);
    super.initState();
  }

_onSearchChanged(){
  print(_searchcontroller.text);
  searchResultList();
}

searchResultList(){
  var showResults = [];

  if(_searchcontroller.text != ""){

    for(var clientSnapShot in _resultados )
    {
      var id = clientSnapShot['id'].toString().toLowerCase();
      if(id.contains(_searchcontroller.text.toLowerCase())){
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
    var data = await getFabs();//FirebaseFirestore.instance.collection('fabricaciones').orderBy('ID').get();
    setState(() {
      _resultados = data;
    });
  }

@override
   void dispose () {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
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
        controller: _searchcontroller,
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
             
             Navigator.pushNamed(context, "/edit", arguments: {
              "ID": _resultlist[index]['ID'],
              "uid": _resultlist[index]['uid']

             });
            
            },
          );
        }));
  }
}