import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/aplikasi.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/screens/pembayaran_keranjang_belanja.dart';
import 'package:uts_moon_store/widgets/box_item_keranjang.dart';
import 'package:uts_moon_store/widgets/constants.dart';

class Keranjang extends StatelessWidget {
  const Keranjang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AplikasiProvider aplikasiProvider =
        Provider.of<AplikasiProvider>(context);

    final BerandaProvider berandaProvider =
        Provider.of<BerandaProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final widthScreen = screenSize.width;
    final paddingScreen = widthScreen * 0.05;

    dynamic totalHarga = 0;

    for (var item in berandaProvider.keranjang) {
      if (item.containsKey('harga')) {
        totalHarga += item['harga'];
      }
    }

    return Stack(
      children: [
        SizedBox(
          height: screenSize.height - ((56 * 3) + (12 * 4) + 91),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(paddingScreen, 12, paddingScreen, 0),
            child: Column(
              children: [
                for (var data in berandaProvider.keranjang) ...{
                  BoxItemKeranjang(data: data),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                    child: Divider(
                      color: primary950.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: (12 * 3) + 91,
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(paddingScreen, 12, paddingScreen, 12),
            color: primary50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: primary950,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Rp. ',
                        style: TextStyle(
                          fontSize: 15,
                          color: primary950,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (totalHarga == 0)
                                ? '0'
                                : totalHarga.toString().substring(0, 3) +
                                    '.' +
                                    totalHarga.toString().substring(3),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  child: Divider(
                    color: primary950.withOpacity(0.2),
                    thickness: 1,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(widthScreen - (paddingScreen * 2), 42),
                    onPrimary: primary50,
                    primary: primary,
                  ),
                  onPressed: () {
                    (totalHarga == 0)
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  aplikasiProvider.halaman = 0;
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.close,
                                    color: primary,
                                  ),
                                ),
                              ),
                              titlePadding:
                                  const EdgeInsets.fromLTRB(0, 12, 12, 0),
                              content:
                                  const Text('Maaf, keranjang Anda kosong'),
                              contentTextStyle: TextStyle(
                                color: primary950,
                                fontSize: 15,
                              ),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PembayaranKeranjangBelanja(
                                totalHarga: totalHarga,
                              ),
                            ),
                          );
                  },
                  child: Text(
                    'BELI (${berandaProvider.keranjang.length})',
                    style: TextStyle(
                      color: primary50,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
