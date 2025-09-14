
// // import 'package:flutter/material.dart';
// // import '../screens/cart_screen.dart';
// // import '../screens/wishlist_screen.dart';

// // class HeaderBar extends StatelessWidget {
// //   final VoidCallback? onMenuPressed; // Add callback for menu button

// //   const HeaderBar({super.key, this.onMenuPressed});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           IconButton(
// //             onPressed: onMenuPressed, // Use the provided callback
// //             icon: const Icon(Icons.menu, color: Colors.grey),
// //             style: IconButton.styleFrom(
// //               backgroundColor: Colors.white.withOpacity(0.6),
// //               fixedSize: const Size(40, 40),
// //             ),
// //           ),
// //           Row(
// //             children: [
// //               IconButton(
// //                 onPressed: () {
// //                   // Navigate to WishlistScreen
// //                   Navigator.of(context).push(
// //                     MaterialPageRoute(builder: (_) => const WishlistScreen()),
// //                   );
// //                 },
// //                 icon: const Icon(Icons.favorite_border, color: Colors.grey),
// //                 style: IconButton.styleFrom(
// //                   backgroundColor: Colors.white.withOpacity(0.6),
// //                   fixedSize: const Size(40, 40),
// //                 ),
// //               ),
// //               const SizedBox(width: 8),
// //               IconButton(
// //                 onPressed: () => Navigator.of(context).push(
// //                   MaterialPageRoute(builder: (_) => const CartScreen()),
// //                 ),
// //                 icon: const Icon(Icons.shopping_bag, color: Colors.grey),
// //                 style: IconButton.styleFrom(
// //                   backgroundColor: Colors.white.withOpacity(0.6),
// //                   fixedSize: const Size(40, 40),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class HeaderBar extends StatelessWidget {
//   final VoidCallback? onMenuPressed;

//   const HeaderBar({super.key, this.onMenuPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             onPressed: onMenuPressed,
//             icon: const Icon(Icons.menu, color: Colors.grey),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white.withOpacity(0.6),
//               fixedSize: const Size(40, 40),
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => context.go('/wishlist'),
//                 icon: const Icon(Icons.favorite_border, color: Colors.grey),
//                 style: IconButton.styleFrom(
//                   backgroundColor: Colors.white.withOpacity(0.6),
//                   fixedSize: const Size(40, 40),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               IconButton(
//                 onPressed: () => context.go('/cart'),
//                 icon: const Icon(Icons.shopping_bag, color: Colors.grey),
//                 style: IconButton.styleFrom(
//                   backgroundColor: Colors.white.withOpacity(0.6),
//                   fixedSize: const Size(40, 40),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

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