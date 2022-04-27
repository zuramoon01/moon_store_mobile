import 'package:flutter/material.dart';

class BerandaProvider extends ChangeNotifier {
  String _kategori = 'Semua';

  String get kategori => _kategori;
  set kategori(String kategoriBaru) {
    _kategori = kategoriBaru;
    notifyListeners();
  }

  List<dynamic> _keranjang = [];
  final List<dynamic> _baju = [
    {
      'kode': 'B1',
      'image': 'assets/images/baju1.jpg',
      'nama': 'Blazer Formal Wilson',
      'harga': 106000,
      'hargaStr': '106.000',
      'status': false,
    },
    {
      'kode': 'B2',
      'image': 'assets/images/baju2.jpg',
      'nama': 'Vicious Jacket',
      'harga': 108000,
      'hargaStr': '108.000',
      'status': false,
    },
  ];
  final List<dynamic> _celana = [
    {
      'kode': 'C1',
      'image': 'assets/images/celana1.jpg',
      'nama': 'Joger Hypebeast',
      'harga': 125000,
      'hargaStr': '125.000',
      'status': false,
    },
    {
      'kode': 'C2',
      'image': 'assets/images/celana2.jpg',
      'nama': 'Camo Unisex',
      'harga': 167000,
      'hargaStr': '167.000',
      'status': false,
    },
  ];
  final List<dynamic> _sepatu = [
    {
      'kode': 'S1',
      'image': 'assets/images/sepatu1.jpg',
      'nama': 'Tactical Army',
      'harga': 145000,
      'hargaStr': '145.000',
      'status': false,
    },
    {
      'kode': 'S2',
      'image': 'assets/images/sepatu2.jpg',
      'nama': 'Natural Navy',
      'harga': 135000,
      'hargaStr': '135.000',
      'status': false,
    },
  ];

  List<dynamic> get keranjang => _keranjang;
  List<dynamic> get baju => _baju;
  List<dynamic> get celana => _celana;
  List<dynamic> get sepatu => _sepatu;

  void cekBarang(String kode, List<dynamic> barang) {
    bool check = false;

    for (var item in barang) {
      if (item['kode'] == kode) {
        for (var itemKeranjang in _keranjang) {
          if (itemKeranjang['kode'] == kode) {
            check = true;
          }
        }

        if (!check) {
          _keranjang.add(item);
          item['status'] = true;
        } else {
          item['status'] = false;
        }
      }
    }
  }

  set tambahKeranjang(String kode) {
    if (kode[0] == 'B') {
      cekBarang(kode, _baju);
    } else if (kode[0] == 'C') {
      cekBarang(kode, _celana);
    } else if (kode[0] == 'S') {
      cekBarang(kode, _sepatu);
    }

    notifyListeners();
  }

  void ubahStatusBarang(String kode, List<dynamic> barang) {
    for (var item in barang) {
      if (item['kode'] == kode) {
        item['status'] = false;
      }
    }
  }

  set hapusBarang(String kode) {
    _keranjang.removeWhere((item) {
      if (item['kode'] == kode) {
        if (kode[0] == 'B') {
          ubahStatusBarang(kode, _baju);
        } else if (kode[0] == 'C') {
          ubahStatusBarang(kode, _celana);
        } else if (kode[0] == 'S') {
          ubahStatusBarang(kode, _sepatu);
        }
      }

      return item['kode'] == kode;
    });

    notifyListeners();
  }

  set hapusKeranjang(bool cek) {
    if (cek) {
      for (var item in _keranjang) {
        if (item['kode'][0] == 'B') {
          cekBarang(item['kode'], _baju);
        } else if (item['kode'][0] == 'C') {
          cekBarang(item['kode'], _celana);
        } else if (item['kode'][0] == 'S') {
          cekBarang(item['kode'], _sepatu);
        }
      }
      _keranjang = [];
      notifyListeners();
    }
  }
}
