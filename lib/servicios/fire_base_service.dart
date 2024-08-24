import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

//leer fabricaciones

Future<List> getFabs() async{
  List fabricaciones = [];
  CollectionReference collectionReferenceFabs = db.collection('fabricaciones');
  QuerySnapshot queryFabs = await collectionReferenceFabs.get();

  queryFabs.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final fabricacion = {
      "ID": data['ID'],
      "uid": documento.id,
    };
    fabricaciones.add(fabricacion);
  });

  return fabricaciones;
}

//añadir fabricaciones

Future<void> addFabs(String id) async {
  var result = await db.collection("fabricaciones").add({"ID": id});
  await coleccionBob(
    id: result.id
  );

}

//actualizar fabricaciones

Future<void> updatefabs(String uid, String newID)async{
  await db.collection("fabricaciones").doc(uid).set({"ID": newID});
}

//borrar fabricaciones

Future<void> deletefabs(String uid) async {
  await db.collection("fabricaciones").doc(uid).delete();
}

//leer bobinas

Future<List> getBobs(String? id) async{
  List bobinas = [];
  CollectionReference collectionReferenceBobs = db.collection('fabricaciones').doc(id).collection('bobinas');
  QuerySnapshot queryBobs = await collectionReferenceBobs.get();

  queryBobs.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final bobina = {
      "np": data['np'],
      "progreso": data['progreso'],
      "meta": data['meta'],
      "uuid": documento.id,
      "alerta": data['alerta']
    };
    bobinas.add(bobina);
  });

  return bobinas;
}

//crear sub coleccion bobinas

Future<String?> coleccionBob({String? id}) async {
  CollectionReference bobs = db.collection('fabricaciones');
  
  bobs.doc(id).collection('bobinas').add({
   'np': "prueba",
   'meta': 0,
   'progreso': 0
  });
  
  return 'exito';

}

// añadir bobinas

Future<void> addbob(String? uid, String? np, int? meta) async {
await db.collection("fabricaciones").doc(uid).collection("bobinas").add({
    'np': np,
    'meta': meta,
    'progreso': 0,
    'alerta': 0,
    });
     

}

// actualizar bobinas

Future<void> updatebobs(String uid, String uuid, double newavance, int meta, String np)async{
  final hoy = DateFormat('dd-MM').format(DateTime.now());
await db.collection("fabricaciones").doc(uid).collection("bobinas").doc(uuid).collection("avance").add({
    "avancediario": newavance,
    "fecha": hoy,
    "meta": meta,
    "np": np,
    });
}

// leer avance

Future<List> avancebob(String? id, String? uid) async{
  List avance = [];
  CollectionReference collectionReferenceFabs = db.collection('fabricaciones').doc(id).collection('bobinas').doc(uid).collection('avance');
  QuerySnapshot queryFabs = await collectionReferenceFabs.get();

  queryFabs.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final dataavance = {
    "avancediario": data['avancediario'].toString(),
    "fecha": data['fecha'],
    "uuuid": documento.id
    };
    avance.add(dataavance);

  });

  return avance;
}

// suma avance

Future<double> avancetot(String? id ,String? uid) async{
  double avtotal = 0;
  CollectionReference collectionReferenceav = db.collection('fabricaciones').doc(id).collection('bobinas').doc(uid).collection('avance');
  QuerySnapshot queryav = await collectionReferenceav.get();
  queryav.docs.forEach((f) => avtotal += f.get('avancediario'));


  return avtotal;
}

// borrar avance
  Future<void> borraravance(String? id , String? uid , String? uuid) async{
    await db.collection('fabricaciones').doc(id).collection('bobinas').doc(uid).collection('avance').doc(uuid).delete();
  }

// cambio aleerta

Future<void> modalerta(String?id, String? uid) async {
db.collection("fabricaciones").doc(id).collection("bobinas").doc(uid).update({
                "alerta": 1
            }); 
}

// cambio aleerta

Future<void> modalertaon(String?id, String? uid) async {
db.collection("fabricaciones").doc(id).collection("bobinas").doc(uid).update({
                "alerta": 0
            }); 
}






