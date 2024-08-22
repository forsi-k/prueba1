import 'package:flutter/material.dart';

class Indexnum with ChangeNotifier {
  int _selectindex = 0;

  int get selectindex => _selectindex;

  Future<void> indexchange({required int value1}) async {
    _selectindex = value1;
    notifyListeners();
  }
}

class FabNum with ChangeNotifier {
  int _fabnum = 0;

  int get fabnum => _fabnum;

  Future<void> fabchange({required int value1}) async {
    _fabnum = value1;
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

class bobdatos with ChangeNotifier {
  String _IDbob = "";
  int _Progreso = 0;
  int _meta = 0;

  String get IDbob => _IDbob;
  int get Progreso => _Progreso;
  int get meta => _meta;

  Future<void> bobdatoschange({required String value1, required int value2, required int value3}) async {
    _IDbob = value1;
    _Progreso = value2;
    _meta = value3;
    notifyListeners();
  }
}

