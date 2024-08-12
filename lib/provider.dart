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

class Bobprogress with ChangeNotifier {
  int _bobprogress = 0;

  int get bobprogress => _bobprogress;

  Future<void> bobpchange({required int value1}) async {
    _bobprogress = value1;
    notifyListeners();
  }
}

class Bobmeta with ChangeNotifier {
  int _bobmeta = 0;

  int get bobmeta => _bobmeta;

  Future<void> bobmchange({required int value1}) async {
    _bobmeta = value1;
    notifyListeners();
  }
}
