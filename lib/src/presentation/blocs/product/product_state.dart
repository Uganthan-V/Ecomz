
part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  final bool hasReachedMax;
  ProductLoaded({required this.products, this.hasReachedMax = false});
  @override
  List<Object?> get props => [products, hasReachedMax];
}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
class ProductEmpty extends ProductState {}