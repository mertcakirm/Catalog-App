import 'package:flutter/material.dart';

import '../utils/product_utils.dart';

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String? selected; // null = Tümü
  final ValueChanged<String?> onSelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelected,
  });

  // Kategori adına göre şık ve rastgele/uyumlu ikonlar üreten yardımcı fonksiyon
  IconData _getCategoryIcon(String? categoryName) {
    if (categoryName == null) return Icons.grid_view_rounded; // 'Tümü' için

    // Örnek bazı anahtar kelimelere göre özel ikonlar, eşleşmezse hash ile rastgele ikon seçilir
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
        name.contains('tech') | name.contains('electronic'))
      return Icons.devices_rounded;
    if (name.contains('cloth') || name.contains('fashion'))
      return Icons.checkroom_rounded;
    if (name.contains('sport')) return Icons.sports_basketball_rounded;

    // Geri kalanlar için kategorinin ismine göre çeşitlilik sağlayan ikon listesi
    const icons = [
      Icons.local_offer_rounded,
      Icons.star_rounded,
      Icons.bolt_rounded,
      Icons.category_rounded,
      Icons.diamond_rounded,
      Icons.shopping_bag_rounded,
      Icons.explore_rounded,
    ];

    return icons[categoryName.hashCode.abs() % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _Chip(
            label: 'Tümü',
            icon: _getCategoryIcon(null),
            selected: selected == null,
            onTap: () => onSelected(null),
          ),
          ...categories.map(
            (c) => _Chip(
              label: prettyText(c),
              icon: _getCategoryIcon(c),
              selected: selected == c,
              onTap: () => onSelected(c),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: selected ? null : Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(22),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: const Color(0xFFE100FF).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
            border: Border.all(
              color: selected
                  ? Colors.white.withOpacity(0.4)
                  : Colors.white.withOpacity(0.12),
              width: selected ? 1.2 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13.5,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
