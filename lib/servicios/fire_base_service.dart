import 'package:cloud_firestore/cloud_firestore.dart';

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
      "uid": documento.id
    };
    bobinas.add(bobina);
  });

  return bobinas;
}

//crear bobinas

Future<String?> coleccionBob({String? id}) async {
  CollectionReference bobs = db.collection('fabricaciones');

  bobs.doc(id).collection('bobinas').add({
    'np': "prueba",
    'progreso': 1,
    'meta': 10,

  });

  return 'exito';

}
