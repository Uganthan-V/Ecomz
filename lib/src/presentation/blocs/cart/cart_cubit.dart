

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/product_model.dart';
import '../../../data/datasources/local_storage.dart';

class CartState extends Equatable {
  final Map<int, Map<String, dynamic>> items; // productId -> {product: Map, qty: int}

  const CartState({this.items = const {}});

  @override
  List<Object?> get props => [items];
}

class CartCubit extends Cubit<CartState> {
  final LocalStorageService localStorage;

  CartCubit({required this.localStorage}) : super(const CartState());

  void loadFromStorage() {
    final map = localStorage.readCart();
    final sanitized = <int, Map<String, dynamic>>{};

    map.forEach((k, v) {
      final productMap = Map<String, dynamic>.from(v as Map);

      if (productMap['product'] is Map) {
        productMap['product'] =
            Map<String, dynamic>.from(productMap['product'] as Map);
      }

      sanitized[int.parse(k)] = productMap;
    });

    emit(CartState(items: sanitized));
  }

  Future<void> addToCart(ProductModel p) async {
    final items = Map<int, Map<String, dynamic>>.from(state.items);
    if (items.containsKey(p.id)) {
      items[p.id]!['qty'] = (items[p.id]!['qty'] as int) + 1;
    } else {
      items[p.id] = {
        'product': p.toJson(),
        'qty': 1,
      };
    }
    await saveAndEmit(items);
  }

  Future<void> removeFromCart(int productId) async {
    final items = Map<int, Map<String, dynamic>>.from(state.items);
    items.remove(productId);
    await saveAndEmit(items);
  }

  Future<void> updateQuantity(int productId, int newQty) async {
    final items = Map<int, Map<String, dynamic>>.from(state.items);

    if (!items.containsKey(productId)) return;

    if (newQty <= 0) {
      items.remove(productId);
    } else {
      items[productId]!['qty'] = newQty;
    }

    await saveAndEmit(items);
  }

  double total() {
    double sum = 0;
    state.items.forEach((_, v) {
      final product = v['product'] as Map<String, dynamic>;
      final price = (product['price'] as num).toDouble();
      final qty = v['qty'] as int;
      sum += price * qty;
    });
    return sum;
  }

  Future<void> saveAndEmit(Map<int, Map<String, dynamic>> items) async {
    await localStorage.saveCart(
      items.map((k, v) => MapEntry(k.toString(), v)),
    );
    emit(CartState(items: items));
  }
}
