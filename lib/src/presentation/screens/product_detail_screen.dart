
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cart/cart_cubit.dart';
import '../blocs/wishlist/wishlist_cubit.dart';
import '../../data/models/product_model.dart';
import '../../data/datasources/product_remote_datasource.dart';
import 'package:dio/dio.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  const ProductDetailScreen({required this.productId, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductModel? _product;
  bool _loading = true;
  final _client = ProductRemoteDataSourceImpl(Dio());
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final p = await _client.getProduct(widget.productId);
      setState(() => _product = p);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load product: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.go('/'); // Navigate to home instead of exiting
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : _product == null
                ? const Center(child: Text('Product not found'))
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.8),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back, color: Colors.grey),
                                    onPressed: () => context.go('/'),
                                  ),
                                ),
                                BlocBuilder<WishlistCubit, List<int>>(
                                  builder: (context, wishlist) {
                                    final saved = wishlist.contains(_product!.id);
                                    return CircleAvatar(
                                      backgroundColor: saved ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.8),
                                      child: IconButton(
                                        icon: Icon(
                                          saved ? Icons.favorite : Icons.favorite_border,
                                          color: saved ? Colors.red : Colors.grey,
                                        ),
                                        onPressed: () => context.read<WishlistCubit>().toggle(_product!.id),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 320,
                            child: Stack(
                              children: [
                                PageView.builder(
                                  itemCount: _product!.images.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      _product!.images[index].toString(),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    );
                                  },
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      _product!.images.length,
                                      (index) => AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.symmetric(horizontal: 4),
                                        width: _currentPage == index ? 10 : 6,
                                        height: _currentPage == index ? 10 : 6,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(_currentPage == index ? 0.9 : 0.5),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _product!.title,
                                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          '\$${_product!.price}',
                                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow[700], size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          _product!.rating.toStringAsFixed(1),
                                          style: const TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Description',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _product!.description,
                                      style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          context.read<CartCubit>().addToCart(_product!);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Added to cart')),
                                          );
                                        },
                                        icon: const Icon(Icons.shopping_cart, color: Colors.white),
                                        label: const Text(
                                          'Add to Cart',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple[600],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          shadowColor: Colors.purpleAccent,
                                          elevation: 8,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}