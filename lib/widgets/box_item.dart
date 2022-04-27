import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/widgets/constants.dart';

class BoxItem extends StatelessWidget {
  final double boxItemWidth;
  final Map<String, dynamic> data;

  const BoxItem({
    Key? key,
    required this.boxItemWidth,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BerandaProvider berandaProvider =
        Provider.of<BerandaProvider>(context);

    return Container(
      width: boxItemWidth,
      decoration: BoxDecoration(
        color: primary50,
        borderRadius: BorderRadius.circular(6),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Stack(
            children: <Widget>[
              Image.asset(
                data['image'],
                width: boxItemWidth,
                height: 180,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: GestureDetector(
                  onTap: () {
                    berandaProvider.tambahKeranjang = data['kode'];
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: primary50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      (data['status']) ? Icons.check : Icons.add,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 2),
              child: Text(
                data['nama'],
                style: TextStyle(
                  color: primary950,
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
              child: RichText(
                text: TextSpan(
                  text: 'Rp. ',
                  style: TextStyle(
                    fontSize: 15,
                    color: primary950,
                  ),
                  children: <TextSpan>[
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
            ),
          ),
        ],
      ),
    );
  }
}
