import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

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


Future<void> addFabs(String id) async {
  var result = await db.collection("fabricaciones").add({"ID": id});
  coleccionBob(
    id: result.id
  );
}

Future<String?> coleccionBob({String? id}) async {
  CollectionReference collectionReferenceFabs = db.collection('fabricaciones');

  collectionReferenceFabs.doc(id).collection('bobinas').add({
    'id': id
  });

  return 'exito';

}

Future<void> updatefabs(String uid, String newID)async{
  await db.collection("fabricaciones").doc(uid).set({"ID": newID});
}

Future<void> deletefabs(String uid) async {
  await db.collection("fabricaciones").doc(uid).delete();
}

Future<List> getBobs(String uid) async{
  List bobinas = [];
  CollectionReference collectionReferenceBobs = db.collection('fabricaciones').doc(uid).collection('bobinas');
  QuerySnapshot queryFabs = await collectionReferenceBobs.get();

  queryFabs.docs.forEach((documento) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final bobina = {
      "ID": data['ID'],
      "uid": documento.id,
    };
    bobinas.add(bobina);
  });

  return bobinas;
}