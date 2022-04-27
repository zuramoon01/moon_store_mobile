import 'package:flutter/material.dart';

class AplikasiProvider extends ChangeNotifier {
  int _halaman = 0;

  int get halaman => _halaman;
  set halaman(int halaman) {
    _halaman = (halaman > 1) ? 1 : halaman;
    notifyListeners();
  }
}
