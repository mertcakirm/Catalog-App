import 'package:flutter/material.dart';

import '../services/favorites_service.dart';
import '../widgets/glass_search_bar.dart';
import '../widgets/page_header.dart';
import '../widgets/product_grid.dart';

class LikedProductsPage extends StatefulWidget {
  const LikedProductsPage({super.key});

  @override
  State<LikedProductsPage> createState() => _LikedProductsPageState();
}

class _LikedProductsPageState extends State<LikedProductsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: FavoritesService.instance.liked,
          builder: (context, liked, _) {
            final q = _searchController.text.trim().toLowerCase();
            final items = liked.where((p) {
              final text = '${p['title']} ${p['brand'] ?? ''} ${p['category']}'
                  .toLowerCase();
              return text.contains(q);
            }).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      children: [
                        PageHeader(
                          title: 'Favorilerim ❤️',
                          subtitle: '${liked.length} ürün beğendin',
                          trailing: liked.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Tümünü temizle',
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.white70,
                                  ),
                                  onPressed: () => _confirmClear(context),
                                ),
                        ),
                        if (liked.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          GlassSearchBar(
                            controller: _searchController,
                            hint: 'Favorilerde ara...',
                            onChanged: () => setState(() {}),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (liked.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: _EmptyState(),
                  )
                else if (items.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'Aramana uygun favori bulunamadı 😕',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  )
                else
                  ProductGrid(products: items),
              ],
            );
          },
        ),
      ),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF241548),
        title: const Text(
          'Favoriler temizlensin mi?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Tüm favori ürünlerin silinecek.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () {
              FavoritesService.instance.clear();
              Navigator.pop(ctx);
            },
            child: const Text(
              'Temizle',
              style: TextStyle(color: Colors.pinkAccent),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.pinkAccent,
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Henüz favorin yok',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Ürünlerdeki kalbe dokunarak buraya ekleyebilirsin',
            style: TextStyle(color: Colors.white54, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
