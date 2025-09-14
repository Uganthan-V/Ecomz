

// // import 'package:flutter/material.dart';
// // import '../screens/cart_screen.dart';
// // import '../screens/product_list_screen.dart';
// // import '../screens/wishlist_screen.dart';

// // class CustomBottomNavigationBar extends StatefulWidget {
// //   const CustomBottomNavigationBar({super.key});

// //   @override
// //   State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
// // }

// // class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
// //   int _selectedIndex = 0;

// //   void _onItemTapped(int index, BuildContext context) {
// //     // Do nothing if the tapped index is the same as the current index
// //     if (_selectedIndex == index) return;

// //     setState(() {
// //       _selectedIndex = index;
// //     });

// //     switch (index) {
// //       case 0: // Shop
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(builder: (_) => const ProductListScreen()),
// //         );
// //         break;
// //       case 1: // Cart
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (_) => const CartScreen()),
// //         );
// //         break;
// //       case 2: // Favorites
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(builder: (_) => const WishlistScreen()),
// //         );
// //         break;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ClipRRect(
// //       borderRadius: const BorderRadius.only(
// //         topLeft: Radius.circular(16),
// //         topRight: Radius.circular(16),
// //       ),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Colors.white.withOpacity(0.0), // Transparent at the top to blend with screen
// //               const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8), // Main color
// //             ],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //           boxShadow: const [
// //             BoxShadow(
// //               color: Color.fromRGBO(0, 0, 0, 0.05),
// //               offset: Offset(0, -4),
// //               blurRadius: 16,
// //             ),
// //           ],
// //         ),
// //         child: SafeArea(
// //           top: false, // No extra padding at the top
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               _buildNavItem(Icons.category, 'Shop', isSelected: _selectedIndex == 0, onTap: () => _onItemTapped(0, context)),
// //               _buildNavItem(Icons.shopping_cart, 'Cart', isSelected: _selectedIndex == 1, onTap: () => _onItemTapped(1, context)),
// //               _buildNavItem(Icons.favorite_border, 'Favorites', isSelected: _selectedIndex == 2, onTap: () => _onItemTapped(2, context)),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildNavItem(IconData icon, String label, {required bool isSelected, required VoidCallback onTap}) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 8.0),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Icon(
// //               icon,
// //               color: isSelected ?  Colors.grey : Colors.grey,
// //               size: 24,
// //             ),
// //             Text(
// //               label,
// //               style: TextStyle(
// //                 fontSize: 12,
// //                 fontWeight: FontWeight.w500,
// //                 color: isSelected ?  Colors.grey : Colors.grey,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class CustomBottomNavigationBar extends StatefulWidget {
//   const CustomBottomNavigationBar({super.key});

//   @override
//   State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index, BuildContext context) {
//     if (_selectedIndex == index) return;

//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0: // Shop
//         context.go('/');
//         break;
//       case 1: // Cart
//         context.go('/cart');
//         break;
//       case 2: // Favorites
//         context.go('/wishlist');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get the current route path
//     final currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.path;

//     // Set selected index based on the current route
//     if (currentRoute == '/') {
//       _selectedIndex = 0;
//     } else if (currentRoute == '/cart') {
//       _selectedIndex = 1;
//     } else if (currentRoute == '/wishlist') {
//       _selectedIndex = 2;
//     } else {
//       // Default to Shop (home) if on another route (e.g., /product/:id)
//       _selectedIndex = 0;
//     }

//     return ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(16),
//         topRight: Radius.circular(16),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white.withOpacity(0.0),
//               const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromRGBO(0, 0, 0, 0.05),
//               offset: Offset(0, -4),
//               blurRadius: 16,
//             ),
//           ],
//         ),
//         child: SafeArea(
//           top: false,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(Icons.category, 'Shop', isSelected: _selectedIndex == 0, onTap: () => _onItemTapped(0, context)),
//               _buildNavItem(Icons.shopping_cart, 'Cart', isSelected: _selectedIndex == 1, onTap: () => _onItemTapped(1, context)),
//               _buildNavItem(Icons.favorite_border, 'Favorites', isSelected: _selectedIndex == 2, onTap: () => _onItemTapped(2, context)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String label, {required bool isSelected, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? Colors.purple : Colors.grey,
//               size: 24,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.purple : Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
        context.go('/'); // Use go to reset to home
        break;
      case 1: // Cart
        context.push('/cart'); // Use push to maintain stack
        break;
      case 2: // Favorites
        context.push('/wishlist'); // Use push to maintain stack
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
              Colors.white.withOpacity(0.0),
              const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              offset: Offset(0, -4),
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
              color: isSelected ? Colors.purple : Colors.grey,
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.purple : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}