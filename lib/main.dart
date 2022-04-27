import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_moon_store/providers/aplikasi.dart';
import 'package:uts_moon_store/providers/beranda.dart';
import 'package:uts_moon_store/providers/keranjang.dart';
import 'package:uts_moon_store/screens/beranda.dart';
import 'package:uts_moon_store/screens/keranjang.dart';
import 'package:uts_moon_store/widgets/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AplikasiProvider>(
          create: (context) => AplikasiProvider(),
        ),
        ChangeNotifierProvider<BerandaProvider>(
          create: (context) => BerandaProvider(),
        ),
        ChangeNotifierProvider<KeranjangProvider>(
          create: (context) => KeranjangProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AplikasiProvider aplikasiProvider =
        Provider.of<AplikasiProvider>(context);

    final List<dynamic> halaman = [
      {
        'title': 'MOON',
        'menu': const Beranda(),
      },
      {
        'title': 'Keranjang',
        'menu': const Keranjang(),
      },
    ];
    final List<dynamic> bottomNavigationBarItemData = [
      {
        'icon': const Icon(Icons.home_outlined),
        'activeIcon': const Icon(Icons.home_rounded),
        'label': 'Rumah',
      },
      {
        'icon': const Icon(Icons.local_mall_outlined),
        'activeIcon': const Icon(Icons.local_mall_rounded),
        'label': 'Keranjang',
      },
      {
        'icon': const Icon(Icons.person_outline_rounded),
        'activeIcon': const Icon(Icons.person_rounded),
        'label': 'Profil',
      },
    ];

    return MaterialApp(
      title: 'UTS Moon Store',
      theme: ThemeData(
        fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: primary,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            halaman[aplikasiProvider.halaman]['title'],
            style: TextStyle(
              fontFamily:
                  (aplikasiProvider.halaman != 0) ? 'Poopins' : 'LimeLight',
              fontSize: (aplikasiProvider.halaman != 0) ? 20 : 24,
              color: primary50,
              letterSpacing: (aplikasiProvider.halaman != 0) ? 0 : 8,
            ),
          ),
        ),
        backgroundColor: primary100,
        body: SafeArea(
          child: halaman[aplikasiProvider.halaman]['menu'],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primary50,
          iconSize: 24,
          showSelectedLabels: false,
          selectedIconTheme: IconThemeData(color: primary),
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(color: primary200),
          items: <BottomNavigationBarItem>[
            for (dynamic data in bottomNavigationBarItemData)
              BottomNavigationBarItem(
                icon: data['icon'],
                activeIcon: data['activeIcon'],
                label: data['label'],
              ),
          ],
          currentIndex: aplikasiProvider.halaman,
          onTap: (halaman) {
            aplikasiProvider.halaman = halaman;
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
