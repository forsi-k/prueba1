import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//leer fabricaciones

Future<List> getFabs() async {
  List fabricaciones = [];
  CollectionReference collectionReferenceFabs = db.collection('fabricaciones');
  QuerySnapshot queryFabs = await collectionReferenceFabs.get();

  for (var documento in queryFabs.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final fabricacion = {
      "ID": data['ID'],
      "uid": documento.id,
    };
    fabricaciones.add(fabricacion);
  }

  return fabricaciones;
}

//añadir fabricaciones

Future<void> addFabs(String id) async {
  var result = await db.collection("fabricaciones").add({"ID": id});
  await coleccionBob(id: result.id);
}

//actualizar fabricaciones

Future<void> updatefabs(String uid, String newID) async {
  await db.collection("fabricaciones").doc(uid).set({"ID": newID});
}

//borrar fabricaciones

Future<void> deletefabs(String uid) async {
  await db.collection("fabricaciones").doc(uid).delete();
}

//borrar bobinas
Future<void> deletebobs(String uid, String? id) async {
  await db
      .collection("fabricaciones")
      .doc(uid)
      .collection('bobinas')
      .doc(id)
      .delete();
}
//leer bobinas

Future<List> getBobs(String? id) async {
  List bobinas = [];
  CollectionReference collectionReferenceBobs =
      db.collection('fabricaciones').doc(id).collection('bobinas');
  QuerySnapshot queryBobs = await collectionReferenceBobs.get();

  for (var documento in queryBobs.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final bobina = {
      "np": data['np'],
      "progreso": data['progreso'],
      "meta": data['meta'],
      "uuid": documento.id,
      "alerta": data['alerta'],
      "maquina": data['maquina']
    };
    bobinas.add(bobina);
  }

  return bobinas;
}

//crear sub coleccion bobinas

Future<String?> coleccionBob({String? id}) async {
  CollectionReference bobs = db.collection('fabricaciones');

  bobs.doc(id).collection('bobinas');

  return 'exito';
}

// añadir bobinas
String formatDate(DateTime date) {
  return date.toIso8601String();
}

Future<void> addbob(String? uid, String? np, int? meta, int? maquina,
    DateTime startDate, DateTime endDate) async {
  await db.collection("fabricaciones").doc(uid).collection("bobinas").add({
    'np': np,
    'meta': meta,
    'progreso': 0.0,
    'alerta': 0,
    'maquina': maquina,
    'Inicio': formatDate(startDate),
    'Final': formatDate(endDate)
  });
}

//actulizar bobinas

Future<void> updbob(
    String? uid, String? uuid, String? np, int? meta, int? maquina) async {
  await db
      .collection("fabricaciones")
      .doc(uid)
      .collection("bobinas")
      .doc(uuid)
      .update({
    'np': np,
    'meta': meta,
    'maquina': maquina,
  });
}

// borrar bobinas

Future<void> delbob(String? uid, String? uuid) async {
  await db
      .collection("fabricaciones")
      .doc(uid)
      .collection("bobinas")
      .doc(uuid)
      .delete();
}

// cargar avance

Future<void> cargaravan(String uid, String uuid, double newavance, int meta,
    String np, String turno) async {
  final hoy = DateFormat('dd-MM').format(DateTime.now());
  await db
      .collection("fabricaciones")
      .doc(uid)
      .collection("bobinas")
      .doc(uuid)
      .collection("avance")
      .add({
    "avancediario": newavance,
    "fecha": hoy,
    "meta": meta,
    "np": np,
    "Turno": turno,
  });
}

// leer avance

Future<List> avancebob(String? id, String? uid) async {
  List avance = [];
  CollectionReference collectionReferenceFabs = db
      .collection('fabricaciones')
      .doc(id)
      .collection('bobinas')
      .doc(uid)
      .collection('avance');
  QuerySnapshot queryFabs = await collectionReferenceFabs.get();

  for (var documento in queryFabs.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final dataavance = {
      "avancediario": data['avancediario'].toString(),
      "fecha": data['fecha'],
      "uuuid": documento.id,
      "Turno": data['Turno']
    };
    avance.add(dataavance);
  }

  return avance;
}

// suma avance

Future<double> avancetot(String? id, String? uid) async {
  double avtotal = 0;
  CollectionReference collectionReferenceav = db
      .collection('fabricaciones')
      .doc(id)
      .collection('bobinas')
      .doc(uid)
      .collection('avance');
  QuerySnapshot queryav = await collectionReferenceav.get();
  for (var f in queryav.docs) {
    avtotal += f.get('avancediario');
  }

  return avtotal;
}

// borrar avance
Future<void> borraravance(String? id, String? uid, String? uuid) async {
  await db
      .collection('fabricaciones')
      .doc(id)
      .collection('bobinas')
      .doc(uid)
      .collection('avance')
      .doc(uuid)
      .delete();
}

// cambio aleerta

Future<void> modalerta(String? id, String? uid) async {
  db
      .collection("fabricaciones")
      .doc(id)
      .collection("bobinas")
      .doc(uid)
      .update({"alerta": 1});
}

// cambio aleerta

Future<void> modalertaon(String? id, String? uid) async {
  db
      .collection("fabricaciones")
      .doc(id)
      .collection("bobinas")
      .doc(uid)
      .update({"alerta": 0});
}

// get users

Future<List> getUsers() async {
  List Usuarios = [];
  CollectionReference collectionReferenceFabs = db.collection('users');
  QuerySnapshot queryFabs = await collectionReferenceFabs.get();

  for (var documento in queryFabs.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final fabricacion = {
      "Apellido": data["Apellido"],
      "Nombre": data["Nombre"],
      "Legajo": data["legajo"],
      "TurnoAct": data["TurnoAct"],
      "Macact": data["Macact"]
    };
    Usuarios.add(fabricacion);
  }

  return Usuarios;
}

Future<List> Getmaquser(int? maquina) async {
  List Maquser = [];
  CollectionReference collectionReferenceuser = db.collection('users');
  QuerySnapshot queryFabs = await collectionReferenceuser.get();
  for (var documento in queryFabs.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    int maquinact = int.parse(data["Macact"]);
    if (maquina == maquinact) {
      final maquser = {
        "Apellido": data["Apellido"],
        "Nombre": data["Nombre"],
        "Legajo": data["legajo"],
        "TurnoAct": data["TurnoAct"],
      };
      Maquser.add(maquser);
    }
  }
  return Maquser;
}

Future<void> updateUsers(String? maquina, String? turno, String uid) async {
  db.collection('users').doc(uid).update({
    "Macact": maquina,
    "TurnoAct": turno,
  });
}
