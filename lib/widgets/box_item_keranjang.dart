import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/widgets/constants.dart';

class BoxItemKeranjang extends StatelessWidget {
  final Map<String, dynamic> data;

  const BoxItemKeranjang({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BerandaProvider berandaProvider =
        Provider.of<BerandaProvider>(context);

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Image.asset(
            data['image'],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['nama'],
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
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
                  children: [
                    TextSpan(
                      text: data['hargaStr'],
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
        ),
        GestureDetector(
          onTap: () {
            berandaProvider.hapusBarang = data['kode'];
          },
          child: Icon(
            Icons.delete_rounded,
            color: primary,
          ),
        ),
      ],
    );
  }
}
