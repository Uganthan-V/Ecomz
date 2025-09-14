
import 'package:hive/hive.dart';

class LocalStorageService {
  final Box _cart = Hive.box('cart');
  final Box _wishlist = Hive.box('wishlist');
  final Box _cache = Hive.box('cache');

  // Cart
  Map<String, dynamic> readCart() {
    final map = _cart.get('items');
    if (map == null) return {};
    return Map<String, dynamic>.from(map as Map);
  }

  Future<void> saveCart(Map<String, dynamic> cart) async {
    await _cart.put('items', cart);
  }

  // Wishlist
  List<int> readWishlist() {
    final list = _wishlist.get('items');
    if (list == null) return [];
    return List<int>.from(list as List);
  }

  Future<void> saveWishlist(List<int> list) async {
    await _wishlist.put('items', list);
  }

  // Cache
  Map<String, dynamic> readCache(String key) {
    final map = _cache.get(key);
    if (map == null) return {};
    return Map<String, dynamic>.from(map as Map);
  }

  Future<void> saveCache(String key, Map<String, dynamic> data) async {
    await _cache.put(key, data);
  }
}