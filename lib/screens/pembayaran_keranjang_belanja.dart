import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/aplikasi.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/providers/keranjang.dart';
import 'package:uts_moon_store/widgets/constants.dart';

// ignore: must_be_immutable
class PembayaranKeranjangBelanja extends StatelessWidget {
  dynamic totalHarga;

  PembayaranKeranjangBelanja({Key? key, required this.totalHarga})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AplikasiProvider aplikasiProvider =
        Provider.of<AplikasiProvider>(context);

    final BerandaProvider berandaProvider =
        Provider.of<BerandaProvider>(context);

    final KeranjangProvider keranjangProvider =
        Provider.of<KeranjangProvider>(context);

    final screenSize = MediaQuery.of(context).size;
    final widthScreen = screenSize.width;
    final paddingScreen = widthScreen * 0.05;

    List<String> jenisPembayaran = ['Tunai', 'Non Tunai'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang',
          style: TextStyle(
            fontSize: 20,
            color: primary50,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: primary100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(paddingScreen, 12, paddingScreen, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Pembayaran',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: primary950,
                  ),
                ),
              ),
              Divider(
                color: primary950.withOpacity(0.1),
                thickness: 2,
              ),
              _judulPembayaran('Total Harga'),
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
              _judulPembayaran('Alamat'),
              TextField(
                controller: keranjangProvider.alamat,
                cursorColor: primary950,
                decoration: InputDecoration(
                  fillColor: primary50,
                  filled: true,
                  errorText: (keranjangProvider.cekAlamat)
                      ? null
                      : 'Alamat tidak boleh kosong',
                  errorStyle: const TextStyle(color: Colors.red),
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: primary950,
                ),
                onEditingComplete: () {
                  keranjangProvider.alamatSelesai = '';
                  keranjangProvider.cekAlamatText =
                      keranjangProvider.alamat.text;
                },
              ),
              _judulPembayaran('Model Pembayaran'),
              for (String jenis in jenisPembayaran) ...{
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Radio(
                        value: jenis,
                        groupValue: keranjangProvider.gvJenisPembayaran,
                        onChanged: (value) {
                          keranjangProvider.gvJenisPembayaran =
                              (keranjangProvider.gvJenisPembayaran == jenis)
                                  ? 'JenisPembayaran'
                                  : value as String;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        keranjangProvider.gvJenisPembayaran =
                            (keranjangProvider.gvJenisPembayaran == jenis)
                                ? 'JenisPembayaran'
                                : jenis;
                      },
                      child: Text(
                        jenis,
                        style: TextStyle(
                          fontSize: 15,
                          color: primary950,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              },
              const SizedBox(height: 42),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: Size(widthScreen - (paddingScreen * 2), 42),
                  onPrimary: primary50,
                  primary: primary,
                ),
                onPressed: () {
                  if (keranjangProvider.alamat.text == '') {
                    keranjangProvider.cekAlamatText =
                        keranjangProvider.alamat.text;
                  }
                  if (keranjangProvider.gvJenisPembayaran ==
                      'JenisPembayaran') {
                    _popUpMessage(
                      context,
                      aplikasiProvider,
                      berandaProvider,
                      'Pilih salah satu model pembayaran',
                      false,
                    );
                  }

                  if (keranjangProvider.alamat.text != '' &&
                      keranjangProvider.gvJenisPembayaran !=
                          'JenisPembayaran') {
                    _popUpMessage(
                      context,
                      aplikasiProvider,
                      berandaProvider,
                      'Proses pembayaran berhasil dilakukan',
                      true,
                    );
                  }
                },
                child: Text(
                  'Proses Pembayaran (${(totalHarga == 0) ? '0' : totalHarga.toString().substring(0, 3) + '.' + totalHarga.toString().substring(3)})',
                  style: TextStyle(
                    color: primary50,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _judulPembayaran(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: primary950,
        ),
      ),
    );
  }

  Future<dynamic> _popUpMessage(
      BuildContext context,
      AplikasiProvider aplikasiProvider,
      BerandaProvider berandaProvider,
      String text,
      bool cekPenambahanFungsi) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            if (cekPenambahanFungsi) {
              berandaProvider.hapusKeranjang = cekPenambahanFungsi;
              aplikasiProvider.halaman = 0;
              Navigator.pop(context);
            }
          },
          child: Container(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.close,
              color: primary,
            ),
          ),
        ),
        titlePadding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
        content: Text(text),
        contentTextStyle: TextStyle(
          color: primary950,
          fontSize: 15,
        ),
      ),
    );
  }
}
