import 'package:flutter/material.dart';

import 'product_card.dart';
import 'product_detail_sheet.dart';

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.66,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final p = products[index];
            return ProductCard(
              product: p,
              onTap: () => showProductDetailSheet(context, p),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}