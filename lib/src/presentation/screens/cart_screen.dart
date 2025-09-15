

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
              'Cart',
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
          body: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return Center(
                  child: Text(
                    'Cart is empty',
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                );
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
                            child: Icon(Icons.delete, color: Theme.of(context).iconTheme.color),
                          ),
                          onDismissed: (_) {
                            final removedItem = state.items[key];
                            context.read<CartCubit>().removeFromCart(key);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Item removed from cart',
                                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                ),
                                duration: const Duration(seconds: 3),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  textColor: Theme.of(context).primaryColor,
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
                                  child: product['images'] != null && (product['images'] as List).isNotEmpty
                                      ? Image.network(
                                          product['images'][0],
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
                                        product['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).textTheme.bodyLarge!.color,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.remove, color: Theme.of(context).iconTheme.color),
                                            onPressed: () {
                                              if (qty > 1) {
                                                context.read<CartCubit>().updateQuantity(key, qty - 1);
                                                ScaffoldMessenger.of(context).clearSnackBars();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Quantity decreased',
                                                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                                    ),
                                                    duration: const Duration(seconds: 3),
                                                    action: SnackBarAction(
                                                      label: 'Undo',
                                                      textColor: Theme.of(context).primaryColor,
                                                      onPressed: () {
                                                        context.read<CartCubit>().updateQuantity(key, qty);
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          Text(
                                            '$qty',
                                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
                                            onPressed: () {
                                              context.read<CartCubit>().updateQuantity(key, qty + 1);
                                              ScaffoldMessenger.of(context).clearSnackBars();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Quantity increased',
                                                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                                                  ),
                                                  duration: const Duration(seconds: 3),
                                                  action: SnackBarAction(
                                                    label: 'Undo',
                                                    textColor: Theme.of(context).primaryColor,
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
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).textTheme.bodyMedium!.color,
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleLarge!.color,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Checkout logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                            foregroundColor: Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Checkout',
                            style: TextStyle(
                              color: Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                            ),
                          ),
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