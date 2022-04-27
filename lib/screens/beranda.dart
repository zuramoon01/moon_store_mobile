import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/aplikasi.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/widgets/box_item.dart';
import 'package:uts_moon_store/widgets/constants.dart';

class Beranda extends StatelessWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AplikasiProvider aplikasiProvider =
        Provider.of<AplikasiProvider>(context);

    final BerandaProvider berandaProvider =
        Provider.of<BerandaProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final widthScreen = screenSize.width;
    final paddingScreen = widthScreen * 0.05;
    final boxItemWidth = (widthScreen - (paddingScreen * 2) - 24) / 2;

    final List<String> kategori = ['Semua', 'Baju', 'Celana', 'Sepatu'];

    List<Widget> kategoriBarang(String kategori) {
      List<dynamic> barang = (kategori == 'Baju')
          ? berandaProvider.baju
          : (kategori == 'Celana')
              ? berandaProvider.celana
              : berandaProvider.sepatu;

      return [
        judulKategori(kategori),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (dynamic item in barang)
              BoxItem(
                boxItemWidth: boxItemWidth,
                data: item,
              ),
          ],
        ),
        const SizedBox(height: 18),
      ];
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(paddingScreen, 0, paddingScreen, 0),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: primary50,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: berandaProvider.kategori,
                        icon: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: primary,
                          size: 24,
                        ),
                        isDense: true,
                        dropdownColor: primary50,
                        elevation: 16,
                        style: TextStyle(
                          color: primary,
                          fontSize: 18,
                        ),
                        items: <DropdownMenuItem<String>>[
                          for (var text in kategori)
                            DropdownMenuItem(
                              value: text,
                              child: Text(text),
                            ),
                        ],
                        onChanged: (kategoriBaru) {
                          berandaProvider.kategori = kategoriBaru as String;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          aplikasiProvider.halaman = 1;
                        },
                        icon: Icon(
                          Icons.local_mall_rounded,
                          color: primary50,
                          size: 24,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: primary400,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          berandaProvider.keranjang.length.toString(),
                          style: TextStyle(
                            color: primary50,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (berandaProvider.kategori == 'Baju' ||
                        berandaProvider.kategori == 'Semua') ...{
                      for (Widget widget in kategoriBarang('Baju')) widget,
                    },
                    if (berandaProvider.kategori == 'Celana' ||
                        berandaProvider.kategori == 'Semua') ...{
                      for (Widget widget in kategoriBarang('Celana')) widget,
                    },
                    if (berandaProvider.kategori == 'Sepatu' ||
                        berandaProvider.kategori == 'Semua') ...{
                      for (Widget widget in kategoriBarang('Sepatu')) widget,
                    },
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Align judulKategori(String nama) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Text(
          nama,
          style: TextStyle(
            color: primary950,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
