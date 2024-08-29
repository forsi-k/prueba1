import 'package:flutter/material.dart';

class Indexnum with ChangeNotifier {
  int _selectindex = 0;

  int get selectindex => _selectindex;

  Future<void> indexchange({required int value1}) async {
    _selectindex = value1;
    notifyListeners();
  }
}

class Mail with ChangeNotifier {
  int _mail = 0;

  int get mail => _mail;

  Future<void> mailchange({required int value1}) async {
    _mail = value1;
    notifyListeners();
  }
}

class BobDatos with ChangeNotifier {
  String _idbob = "";
  int _progreso = 0;
  int _meta = 0;

  String get idbob => _idbob;
  int get progreso => _progreso;
  int get meta => _meta;

  Future<void> bobdatoschange(
      {required String value1,
      required int value2,
      required int value3}) async {
    _idbob = value1;
    _progreso = value2;
    _meta = value3;
    notifyListeners();
  }
}

class UserProvider with ChangeNotifier {
  String _userId = "";
  String get userId => _userId;
  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }
}
