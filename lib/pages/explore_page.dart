import 'package:flutter/material.dart';

import '../services/category_service.dart';
import '../widgets/explore_banner.dart';

class ExplorePage extends StatefulWidget {
  final ValueSetter<String>? onCategorySelected;

  const ExplorePage({super.key, this.onCategorySelected});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<dynamic> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryService.instance.fetchCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Bağlantı hatası: $e';
        _isLoading = false;
      });
    }
  }

  // Kategori adına göre rastgele ikonlar üreten fonksiyon
  IconData _getCategoryIcon(String? categoryName) {
    if (categoryName == null) return Icons.category_rounded;

    final name = categoryName.toLowerCase();
    if (name.contains('beauty') || name.contains('makeup'))
      return Icons.face_rounded;
    if (name.contains('fragrance') || name.contains('perfume'))
      return Icons.spa_rounded;
    if (name.contains('furniture') || name.contains('home'))
      return Icons.chair_rounded;
    if (name.contains('grocer') || name.contains('food'))
      return Icons.local_grocery_store_rounded;
    if (name.contains('phone') ||
        name.contains('tech') ||
        name.contains('electronic'))
      return Icons.devices_rounded;
    if (name.contains('cloth') || name.contains('fashion'))
      return Icons.checkroom_rounded;
    if (name.contains('sport')) return Icons.sports_basketball_rounded;

    const icons = [
      Icons.local_offer_rounded,
      Icons.star_rounded,
      Icons.bolt_rounded,
      Icons.category_rounded,
      Icons.diamond_rounded,
      Icons.shopping_bag_rounded,
      Icons.explore_rounded,
      Icons.auto_awesome_rounded,
    ];

    return icons[categoryName.hashCode.abs() % icons.length];
  }

  // Her kart için birbirinden farklı canlı renk kombinasyonları üreten fonksiyon
  List<Color> _getCategoryColors(String? categoryName) {
    if (categoryName == null)
      return [const Color(0xFF7F00FF), const Color(0xFFE100FF)];

    const palettes = [
      [Color(0xFFFF416C), Color(0xFFFF4B2B)], // Kırmızı/Turuncu
      [Color(0xFF8A2387), Color(0xFFE94057)], // Mor/Pembe
      [Color(0xFF1D976C), Color(0xFF93F9B9)], // Yeşil tonları
      [Color(0xFF2C3E50), Color(0xFF4CA1AF)], // Mavi tonları
      [Color(0xFFF7971E), Color(0xFFFFD200)], // Sarı/Turuncu
      [Color(0xFF0052D4), Color(0xFF4364F7)], // Canlı Mavi
      [Color(0xFF833AB4), Color(0xFFFD1D1D)], // Mor/Kırmızı geçiş
      [Color(0xFFEB3349), Color(0xFFF45C43)], // Nar çiçeği
      [Color(0xFF11998E), Color(0xFF38EF7D)], // Mint yeşili
    ];

    return palettes[categoryName.hashCode.abs() % palettes.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER & BANNER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Keşfet ✨',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'İhtiyacın olan her şeyi bul',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Hero Banner
                    const ExploreBanner(),
                    const SizedBox(height: 24),

                    // Kategori Başlığı
                    const Center(
                      child: Text(
                        'Kategoriler',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            // KATEGORİ LİSTESİ
            _isLoading
                ? const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.purpleAccent,
                      ),
                    ),
                  )
                : _errorMessage != null
                ? SliverFillRemaining(
                    child: Center(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 1.35,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final category = _categories[index];

                        final String categoryName = category is Map
                            ? (category['name']?.toString() ?? '')
                            : category.toString();

                        final String categorySlug = category is Map
                            ? (category['slug']?.toString() ??
                                  categoryName.toLowerCase())
                            : category.toString();

                        final iconData = _getCategoryIcon(categoryName);
                        final cardColors = _getCategoryColors(categoryName);

                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(0.12),
                                Colors.white.withOpacity(0.04),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.18),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                if (widget.onCategorySelected != null &&
                                    categorySlug.isNotEmpty) {
                                  widget.onCategorySelected!(categorySlug);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: cardColors,
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: cardColors.first
                                                    .withOpacity(0.4),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            iconData,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white.withOpacity(0.3),
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      categoryName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        letterSpacing: 0.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }, childCount: _categories.length),
                    ),
                  ),

            // SAYFANIN EN ALTINDAKİ LOGO VE BOŞLUK
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 120),
                child: Center(
                  child: Opacity(
                    opacity: 0.8,
                    child: SizedBox(
                      height: 100,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
