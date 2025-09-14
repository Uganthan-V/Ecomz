

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/blocs/wishlist/wishlist_cubit.dart';
import '../../presentation/blocs/product/product_cubit.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/navi_bar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent default pop behavior
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.go('/'); // Navigate to home instead of exiting
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              'Wishlist',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () => context.go('/'),
            ),
          ),
          body: BlocBuilder<WishlistCubit, List<int>>(
            builder: (context, wishlistIds) {
              return BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productState) {
                  if (productState is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (productState is ProductError) {
                    return Center(child: Text('Error: ${productState.message}'));
                  }
                  if (productState is ProductEmpty || wishlistIds.isEmpty) {
                    return const Center(child: Text('Your wishlist is empty'));
                  }
                  if (productState is ProductLoaded) {
                    final wishlistProducts = productState.products
                        .where((product) => wishlistIds.contains(product.id))
                        .toList();

                    if (wishlistProducts.isEmpty) {
                      return const Center(child: Text('Your wishlist is empty'));
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: wishlistProducts.length,
                      itemBuilder: (context, index) {
                        final product = wishlistProducts[index];
                        return GestureDetector(
                          onTap: () => context.push('/product/${product.id}'), // Use push to maintain stack
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: product.images.isNotEmpty
                                      ? Image.network(
                                          product.images[0],
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Icon(Icons.image_not_supported),
                                        )
                                      : const Icon(Icons.image_not_supported),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      context.read<WishlistCubit>().toggle(product.id),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              );
            },
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}