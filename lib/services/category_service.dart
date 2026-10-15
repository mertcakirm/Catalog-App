import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static final CategoryService instance = CategoryService._init();
  CategoryService._init();

  Future<List<dynamic>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products/categories'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Kategoriler yüklenemedi. (Kod: ${response.statusCode})');
      }
    } catch (e) {
      debugPrint('API Hatası: $e');
      rethrow;
    }
  }
}