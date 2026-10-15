import 'package:flutter/material.dart';

import '../services/category_service.dart';
import '../services/favorites_service.dart';
import '../services/product_service.dart';
import '../widgets/category_chips.dart';
import '../widgets/glass_search_bar.dart';
import '../widgets/page_header.dart';
import '../widgets/product_grid.dart';

class ProductsPage extends StatefulWidget {
  final String? initialCategory;

  const ProductsPage({super.key, this.initialCategory});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Map<String, dynamic>> _products = [];
  List<dynamic> _categories = [];
  bool _isLoading = true;
  bool _isCategoriesLoading = true;
  String? _errorMessage;

  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _loadData();
  }

  // Dışarıdan (MainScreen üzerinden) yeni bir kategori parametresi geldiğinde güncellenmesini ve veri çekilmesini sağlar
  @override
  void didUpdateWidget(covariant ProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCategory != oldWidget.initialCategory) {
      setState(() {
        _selectedCategory = widget.initialCategory;
      });
      _loadProducts(); // Kategori değiştiğinde ürünleri yeniden çek
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hem kategorileri hem de başlangıç ürünlerini ilk açılışta paralel çeker
  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        _selectedCategory != null
            ? ProductService.fetchByCategory(_selectedCategory!)
            : ProductService.fetchAll(),
        CategoryService.instance.fetchCategories(),
      ]);

      setState(() {
        _products = results[0] as List<Map<String, dynamic>>;
        _categories = results[1] as List<dynamic>;
        _isLoading = false;
        _isCategoriesLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Bağlantı hatası: ${e.toString().replaceFirst('Exception: ', '')}';
        _isLoading = false;
        _isCategoriesLoading = false;
      });
    }
  }

  // Sadece ürünleri (kategori bazlı veya tümü) güncelleyen yardımcı metot
  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final products = _selectedCategory != null
          ? await ProductService.fetchByCategory(_selectedCategory!)
          : await ProductService.fetchAll();

      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Bağlantı hatası: ${e.toString().replaceFirst('Exception: ', '')}';
        _isLoading = false;
      });
    }
  }

  // API'den gelen verinin slug değerlerini güvenle alıp listeleyen getter
  List<String> get _categoryList {
    final Set<String> uniqueCategories = {};

    for (var c in _categories) {
      if (c is Map) {
        final slug = c['slug']?.toString() ?? c['name']?.toString();
        if (slug != null && slug.isNotEmpty) {
          uniqueCategories.add(slug);
        }
      } else if (c is String && c.isNotEmpty) {
        uniqueCategories.add(c);
      }
    }

    final list = uniqueCategories.toList()..sort();

    // Eğer bir kategori seçilmişse, onu listenin en başına taşıyalım
    if (_selectedCategory != null && list.contains(_selectedCategory)) {
      list.remove(_selectedCategory);
      list.insert(0, _selectedCategory!);
    }

    return list;
  }

  List<Map<String, dynamic>> get _filteredProducts {
    final q = _searchController.text.trim().toLowerCase();
    return _products.where((p) {
      final text = '${p['title']} ${p['brand'] ?? ''} ${p['category']}'
          .toLowerCase();
      return text.contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  children: [
                    PageHeader(
                      title: 'Ürünler 🛍️',
                      subtitle: _isLoading
                          ? 'Yükleniyor...'
                          : '${products.length} ürün listeleniyor',
                      trailing: _FavoriteCountBadge(),
                    ),
                    const SizedBox(height: 20),
                    GlassSearchBar(
                      controller: _searchController,
                      hint: 'Ürün veya marka ara...',
                      onChanged: () => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            if (!_isCategoriesLoading && _errorMessage == null)
              SliverToBoxAdapter(
                child: CategoryChips(
                  categories: _categoryList,
                  selected: _selectedCategory,
                  onSelected: (c) {
                    setState(() {
                      _selectedCategory = c;
                    });
                    _loadProducts(); // Çiplerden kategori seçildiğinde / kaldırıldığında API isteğini yenile
                  },
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            if (_isLoading)
              const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.purpleAccent),
                ),
              )
            else if (_errorMessage != null)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: _loadData,
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: const Text(
                          'Tekrar Dene',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (products.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'Aramana uygun ürün bulunamadı 😕',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              )
            else ...[
              ProductGrid(products: products),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ],
        ),
      ),
    );
  }
}

class _FavoriteCountBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: FavoritesService.instance.liked,
      builder: (context, liked, _) {
        return Badge(
          isLabelVisible: liked.isNotEmpty,
          label: Text('${liked.length}'),
          backgroundColor: Colors.pinkAccent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                liked.isEmpty
                    ? Icons.favorite_border_rounded
                    : Icons.favorite_rounded,
                color: liked.isEmpty ? Colors.white : Colors.pinkAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}
