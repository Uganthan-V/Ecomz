

import '../../data/datasources/product_remote_datasource.dart';
import '../../data/datasources/local_storage.dart';
import '../models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> fetchProducts({int limit, int skip});
  Future<List<ProductModel>> searchProducts(String query, {int limit, int skip});
  Future<ProductModel> getProduct(int id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remote;
  final LocalStorageService local;

  ProductRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<ProductModel>> fetchProducts({int limit = 10, int skip = 0}) async {
    try {
      final items = await remote.fetchProducts(limit: limit, skip: skip);
      // cache
      final cache = items.map((e) => e.toJson()).toList();
      await local.saveCache('products', {'items': cache});
      return items;
    } catch (_) {
      // fallback to cache
      final cached = local.readCache('products');
      final items = (cached['items'] as List?)?.map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e))).toList() ?? [];
      return items;
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      return await remote.getProduct(id);
    } catch (_) {
      final cached = local.readCache('products');
      final items = (cached['items'] as List?)?.map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e))).toList() ?? [];
      final found = items.firstWhere((p) => p.id == id, orElse: () => throw Exception('Not found'));
      return found;
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query, {int limit = 10, int skip = 0}) async {
    try {
      final items = await remote.searchProducts(query, limit: limit, skip: skip);
      return items;
    } catch (_) {
      return [];
    }
  }
}