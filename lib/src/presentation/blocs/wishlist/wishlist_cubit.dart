
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/local_storage.dart';

class WishlistCubit extends Cubit<List<int>> {
  final LocalStorageService localStorage;

  WishlistCubit({required this.localStorage}) : super([]) {
    loadFromStorage(); // Load wishlist on initialization
  }

  void loadFromStorage() {
    final list = localStorage.readWishlist();
    print('Loaded wishlist: $list'); // Debug log
    emit(list);
  }

  Future<void> toggle(int productId) async {
    print('Toggling product ID: $productId'); // Debug log
    final current = List<int>.from(state);
    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }
    await localStorage.saveWishlist(current);
    emit(current);
  }
}