
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index, BuildContext context) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Shop
        context.go('/');
        break;
      case 1: // Cart
        context.push('/cart');
        break;
      case 2: // Favorites
        context.push('/wishlist');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.path;

    if (currentRoute == '/') {
      _selectedIndex = 0;
    } else if (currentRoute == '/cart') {
      _selectedIndex = 1;
    } else if (currentRoute == '/wishlist') {
      _selectedIndex = 2;
    } else {
      _selectedIndex = 0;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor == Colors.transparent
                  ? Colors.white.withOpacity(0.0)
                  : Colors.grey[900]!.withOpacity(0.0),
              Theme.of(context).cardTheme.color!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.category, 'Shop', isSelected: _selectedIndex == 0, onTap: () => _onItemTapped(0, context)),
              _buildNavItem(Icons.shopping_cart, 'Cart', isSelected: _selectedIndex == 1, onTap: () => _onItemTapped(1, context)),
              _buildNavItem(Icons.favorite_border, 'Favorites', isSelected: _selectedIndex == 2, onTap: () => _onItemTapped(2, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}