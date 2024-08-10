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
  await db.collection("fabricaciones").add({"ID": id});
}

Future<void> updatefabs(String uid, String newID)async{
  await db.collection("fabricaciones").doc(uid).set({"ID": newID});
}

Future<void> deletefabs(String uid) async {
  await db.collection("fabricaciones").doc(uid).delete();
}