import 'dart:ui';

import 'package:catalog/widgets/navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass Nav',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Text(
        'Keşfet',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Ürünler',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
    const Center(
      child: Text('Liked', style: TextStyle(fontSize: 24, color: Colors.white)),
    ),
    const Center(
      child: Text(
        'Basket',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Arka plan ışık efektleri
          Positioned(
            top: 150,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purpleAccent,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.cyanAccent,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),

          // Aktif Sayfa İçeriği
          _pages[_currentIndex],
        ],
      ),

      // Ayrı dosyadan çağrılan Liquid Glass Navigation Bar
      bottomNavigationBar: NavigationIsland(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
