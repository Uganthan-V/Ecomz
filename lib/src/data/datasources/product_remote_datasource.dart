

import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({int limit, int skip});
  Future<List<ProductModel>> searchProducts(String query, {int limit, int skip});
  Future<ProductModel> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;
  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> fetchProducts({int limit = 10, int skip = 0}) async {
    final resp = await client.get('$DUMMY_BASE/products', queryParameters: {'limit': limit, 'skip': skip});
    final data = resp.data as Map<String, dynamic>;
    final items = (data['products'] as List).map((e) => ProductModel.fromJson(e)).toList();
    return items;
  }

  @override
  Future<List<ProductModel>> searchProducts(String query, {int limit = 10, int skip = 0}) async {
    final resp = await client.get('$DUMMY_BASE/products/search', queryParameters: {'q': query, 'limit': limit, 'skip': skip});
    final data = resp.data as Map<String, dynamic>;
    final items = (data['products'] as List).map((e) => ProductModel.fromJson(e)).toList();
    return items;
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    final resp = await client.get('$DUMMY_BASE/products/$id');
    return ProductModel.fromJson(resp.data as Map<String, dynamic>);
  }
}