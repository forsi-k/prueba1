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
  bool _mail = false;

  bool get mail => _mail;

  Future<void> avachange({required bool value1}) async {
    _mail = value1;
    notifyListeners();
  }
}

class bobdatos with ChangeNotifier {
  int _IDbob = 0;
  int _Progreso = 0;
  int _porcentaje = 0;

  int get IDbob => _IDbob;
  int get Progreso => _Progreso;
  int get Porcentaje => _porcentaje;

  Future<void> bobdatoschange({required int value1, required int value2, required int value3}) async {
    _IDbob = value1;
    _Progreso = value2;
    _porcentaje = value3;
    notifyListeners();
  }
}

