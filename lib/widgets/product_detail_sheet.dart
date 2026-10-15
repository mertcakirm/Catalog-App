import 'package:flutter/material.dart';

import '../services/favorites_service.dart';
import '../utils/product_utils.dart';

void showProductDetailSheet(BuildContext pageContext, Map<String, dynamic> p) {
  showModalBottomSheet(
    context: pageContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ProductDetailSheet(product: p, pageContext: pageContext),
  );
}

class _ProductDetailSheet extends StatelessWidget {
  final Map<String, dynamic> product;
  final BuildContext pageContext;

  const _ProductDetailSheet({required this.product, required this.pageContext});

  @override
  Widget build(BuildContext context) {
    final p = product;
    final double discount = ((p['discountPercentage'] ?? 0) as num).toDouble();
    final double rating = ((p['rating'] ?? 0) as num).toDouble();
    final int stock = (p['stock'] ?? 0) as int;

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF241548), Color(0xFF120B24)],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  p['thumbnail'] ?? '',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white38,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                (p['brand'] ?? prettyText(p['category'] ?? ''))
                    .toString()
                    .toUpperCase(),
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                p['title'] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(width: 12),
                  _StockBadge(stock: stock),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                p['description'] ?? '',
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              if (p['shippingInformation'] != null)
                _InfoRow(
                  Icons.local_shipping_outlined,
                  p['shippingInformation'],
                ),
              if (p['warrantyInformation'] != null)
                _InfoRow(
                  Icons.verified_user_outlined,
                  p['warrantyInformation'],
                ),
              if (p['returnPolicy'] != null)
                _InfoRow(Icons.assignment_return_outlined, p['returnPolicy']),
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (discount >= 1)
                        Text(
                          '\$${(p['price'] as num).toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white38,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        '\$${discountedPrice(p).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: _FavoriteActionButton(product: p)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Favoriye ekle / favoriden çıkar FavoritesService'i dinler.
class _FavoriteActionButton extends StatelessWidget {
  final Map<String, dynamic> product;

  const _FavoriteActionButton({required this.product});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: FavoritesService.instance.liked,
      builder: (context, _, __) {
        final isFav = FavoritesService.instance.isLiked(product['id']);

        return GestureDetector(
          onTap: () => FavoritesService.instance.toggle(product),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: isFav
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    ),
              color: isFav ? Colors.white.withOpacity(0.08) : null,
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: isFav
                    ? Colors.pinkAccent.withOpacity(0.6)
                    : Colors.transparent,
              ),
              boxShadow: isFav
                  ? []
                  : [
                      BoxShadow(
                        color: const Color(0xFF7F00FF).withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: isFav ? Colors.pinkAccent : Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isFav ? 'Favorilerden Çıkar' : 'Favorilere Ekle',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StockBadge extends StatelessWidget {
  final int stock;
  const _StockBadge({required this.stock});

  @override
  Widget build(BuildContext context) {
    final color = stock > 10 ? Colors.greenAccent : Colors.orangeAccent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        stock > 10 ? 'Stokta ($stock)' : 'Son $stock adet',
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.purpleAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
