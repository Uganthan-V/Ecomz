

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
            icon: Icon(Icons.menu, color: Theme.of(context).iconTheme.color),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).cardTheme.color,
              fixedSize: const Size(40, 40),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => context.push('/wishlist'),
                icon: Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).cardTheme.color,
                  fixedSize: const Size(40, 40),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => context.push('/cart'),
                icon: Icon(Icons.shopping_bag, color: Theme.of(context).iconTheme.color),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).cardTheme.color,
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