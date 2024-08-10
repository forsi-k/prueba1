import 'package:flutter/material.dart';

class Indexnum with ChangeNotifier {
  int _selectindex = 0;

  int get selectindex => _selectindex;

  Future<void> Indexchange({required int value1}) async {
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
