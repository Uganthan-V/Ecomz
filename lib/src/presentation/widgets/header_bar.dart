
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderBar extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const HeaderBar({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(Icons.menu, color: Colors.grey),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.6),
              fixedSize: const Size(40, 40),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => context.push('/wishlist'), // Use push to maintain stack
                icon: const Icon(Icons.favorite_border, color: Colors.grey),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.6),
                  fixedSize: const Size(40, 40),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => context.push('/cart'), // Use push to maintain stack
                icon: const Icon(Icons.shopping_bag, color: Colors.grey),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.6),
                  fixedSize: const Size(40, 40),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}