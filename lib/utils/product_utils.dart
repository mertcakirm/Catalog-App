String prettyText(String s) {
  return s
      .replaceAll('-', ' ')
      .split(' ')
      .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

double discountedPrice(Map<String, dynamic> p) {
  final price = (p['price'] as num).toDouble();
  final d = ((p['discountPercentage'] ?? 0) as num).toDouble();
  return price * (1 - d / 100);
}
