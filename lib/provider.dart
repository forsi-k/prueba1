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

class Avancet with ChangeNotifier {
  int _avancet = 0;

  int get avancet => _avancet;

  Future<void> avachange({required int value1}) async {
    _avancet = value1;
    notifyListeners();
  }
}

class Transpo with ChangeNotifier {
  int _transpo = 0;
  int _transpo2 = 0;

  int get transpo => _transpo;
  int get transpo2 => _transpo2;

  Future<void> transchange({required int value1, required int value2}) async {
    _transpo = value1;
    _transpo2 = value2;
    notifyListeners();
  }
}

