import 'package:catalog/services/favorites_service.dart';
import 'package:flutter/material.dart';

import 'pages/explore_page.dart';
import 'pages/liked_products_page.dart';
import 'pages/products_page.dart';
import 'widgets/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoritesService.instance.init();
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
  String? _selectedCategorySlug; // Keşfet'ten seçilen kategoriyi tutan değişken

  @override
  Widget build(BuildContext context) {
    // Sayfaları her build esnasında güncel parametrelerle oluşturuyoruz
    final List<Widget> pages = [
      ExplorePage(
        onCategorySelected: (slug) {
          setState(() {
            _selectedCategorySlug = slug; // Kategoriyi kaydet
            _currentIndex = 1; // Ürünler sayfasına (Index 1) geçiş yap
          });
        },
      ),
      ProductsPage(
        initialCategory: _selectedCategorySlug, // Seçilen kategoriyi ürünler sayfasına gönder
      ),
      const LikedProductsPage(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: Stack(
        children: [
          Positioned.fill(
            child: IndexedStack(index: _currentIndex, children: pages),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: NavigationIsland(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  if (index == 1) {
                    _selectedCategorySlug = null;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
