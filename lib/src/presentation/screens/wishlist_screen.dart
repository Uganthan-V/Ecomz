
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
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          context.go('/');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Theme.of(context).brightness == Brightness.light
                ? [Colors.purple, Colors.white]
                : [
                    Theme.of(context).primaryColor,
                    Theme.of(context).scaffoldBackgroundColor == Colors.transparent
                        ? Colors.white
                        : Colors.grey[900]!,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Wishlist',
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge!.color,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
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
                    return Center(
                      child: Text(
                        'Your wishlist is empty',
                        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    );
                  }
                  if (productState is ProductLoaded) {
                    final wishlistProducts = productState.products
                        .where((product) => wishlistIds.contains(product.id))
                        .toList();

                    if (wishlistProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'Your wishlist is empty',
                          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: wishlistProducts.length,
                      itemBuilder: (context, index) {
                        final product = wishlistProducts[index];
                        return GestureDetector(
                          onTap: () => context.push('/product/${product.id}'),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).shadowColor.withOpacity(0.1),
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
                                              Icon(Icons.image_not_supported, color: Theme.of(context).iconTheme.color),
                                        )
                                      : Icon(Icons.image_not_supported, color: Theme.of(context).iconTheme.color),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).textTheme.bodyMedium!.color,
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
                                  onPressed: () => context.read<WishlistCubit>().toggle(product.id),
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