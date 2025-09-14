

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/cart/cart_cubit.dart';
import '../widgets/navi_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
              'Cart',
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
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return const Center(child: Text('Cart is empty'));
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final key = state.items.keys.elementAt(index);
                        final v = state.items[key]!;
                        final product = Map<String, dynamic>.from(v['product'] as Map);
                        final qty = v['qty'] as int;
                        return Dismissible(
                          key: Key(key.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          onDismissed: (_) {
                            final removedItem = state.items[key];
                            context.read<CartCubit>().removeFromCart(key);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Item removed from cart'),
                                duration: const Duration(seconds: 3),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    if (removedItem != null) {
                                      final items = Map<int, Map<String, dynamic>>.from(state.items);
                                      items[key] = removedItem;
                                      context.read<CartCubit>().saveAndEmit(items);
                                    }
                                  },
                                ),
                              ),
                            );
                          },
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
                                  child: product['images'] != null && (product['images'] as List).isNotEmpty
                                      ? Image.network(
                                          product['images'][0],
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
                                        product['title'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: () {
                                              if (qty > 1) {
                                                context.read<CartCubit>().updateQuantity(key, qty - 1);
                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: const Text('Quantity decreased'),
                                                    duration: const Duration(seconds: 3),
                                                    action: SnackBarAction(
                                                      label: 'Undo',
                                                      onPressed: () {
                                                        context.read<CartCubit>().updateQuantity(key, qty);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Text('$qty'),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              context.read<CartCubit>().updateQuantity(key, qty + 1);
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: const Text('Quantity increased'),
                                                  duration: const Duration(seconds: 3),
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    onPressed: () {
                                                      context.read<CartCubit>().updateQuantity(key, qty);
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '\$${((product['price'] as num) * qty).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 12),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${context.read<CartCubit>().total().toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Checkout logic
                          },
                          child: const Text('Checkout'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }
}