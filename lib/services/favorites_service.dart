import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  FavoritesService._();
  static final FavoritesService instance = FavoritesService._();

  static const _key = 'liked_products';

  final ValueNotifier<List<Map<String, dynamic>>> liked = ValueNotifier([]);

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return;
    try {
      liked.value = (json.decode(raw) as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } catch (_) {
      liked.value = [];
    }
  }

  bool isLiked(int id) => liked.value.any((p) => p['id'] == id);

  Future<void> toggle(Map<String, dynamic> product) async {
    final list = List<Map<String, dynamic>>.from(liked.value);
    final index = list.indexWhere((p) => p['id'] == product['id']);
    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.add(Map<String, dynamic>.from(product));
    }
    liked.value = list;
    await _save();
  }

  Future<void> clear() async {
    liked.value = [];
    await _save();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, json.encode(liked.value));
  }
}
