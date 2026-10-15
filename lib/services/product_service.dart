import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductService {
  // Tüm ürünler
  static Future<List<Map<String, dynamic>>> fetchAll() async {
    final response = await http.get(
      Uri.parse(
        'https://dummyjson.com/products?limit=0&select=title,description,category,price,discountPercentage,rating,stock,brand,thumbnail,warrantyInformation,shippingInformation,availabilityStatus,returnPolicy',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Ürünler yüklenemedi.');
    }

    final data = json.decode(response.body);
    return (data['products'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  // Belirli bir kategoriye ait ürünler
  static Future<List<Map<String, dynamic>>> fetchByCategory(
    String categorySlug,
  ) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/category/$categorySlug'),
    );

    if (response.statusCode != 200) {
      throw Exception('Kategori ürünleri yüklenemedi.');
    }

    final data = json.decode(response.body);
    return (data['products'] as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
