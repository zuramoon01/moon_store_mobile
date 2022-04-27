import 'package:flutter/material.dart';

class KeranjangProvider extends ChangeNotifier {
  TextEditingController _alamat = TextEditingController();
  bool _cekAlamat = true;

  TextEditingController get alamat => _alamat;
  bool get cekAlamat => _cekAlamat;
  set alamatSelesai(String text) {
    notifyListeners();
  }

  set cekAlamatText(String text) {
    _cekAlamat = (text != '') ? true : false;
    notifyListeners();
  }

  String _gvJenisPembayaran = 'JenisPembayaran';

  String get gvJenisPembayaran => _gvJenisPembayaran;
  set gvJenisPembayaran(String value) {
    _gvJenisPembayaran = value;
    notifyListeners();
  }
}
