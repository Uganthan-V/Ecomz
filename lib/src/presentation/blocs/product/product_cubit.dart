

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/product_repository_impl.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepositoryImpl repo;
  int _skip = 0;
  final int _limit = 10;
  bool _isFetching = false;

  ProductCubit({required this.repo}) : super(ProductInitial());

  Future<void> fetchInitial() async {
    emit(ProductLoading());
    _skip = 0;
    try {
      final items = await repo.fetchProducts(limit: _limit, skip: _skip);
      _skip += items.length;
      if (items.isEmpty) emit(ProductEmpty());
      else emit(ProductLoaded(products: items, hasReachedMax: items.length < _limit));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> refresh() async {
    await fetchInitial();
  }

  Future<void> loadMore() async {
    if (_isFetching || state is ProductLoaded && (state as ProductLoaded).hasReachedMax) return;
    _isFetching = true;
    try {
      final newItems = await repo.fetchProducts(limit: _limit, skip: _skip);
      _skip += newItems.length;
      if (state is ProductLoaded) {
        final current = (state as ProductLoaded).products;
        final combined = List<ProductModel>.from(current)..addAll(newItems);
        emit(ProductLoaded(products: combined, hasReachedMax: newItems.length < _limit));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> search(String query) async {
    emit(ProductLoading());
    try {
      final items = await repo.searchProducts(query);
      if (items.isEmpty) emit(ProductEmpty());
      else emit(ProductLoaded(products: items, hasReachedMax: true));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}