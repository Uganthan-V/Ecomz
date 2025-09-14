

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../blocs/product/product_cubit.dart';
// import '../blocs/auth/auth_cubit.dart'; // Import AuthCubit
// import '../widgets/product_card.dart';
// // import 'product_detail_screen.dart';
// // import 'login_screen.dart'; // Import LoginScreen
// import '../widgets/header_bar.dart';
// import '../widgets/navi_bar.dart';
// import 'package:go_router/go_router.dart';

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   State<ProductListScreen> createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   final _scroll = ScrollController();
//   final _search = TextEditingController();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for controlling the Scaffold

//   @override
//   void initState() {
//     super.initState();
//     _scroll.addListener(() {
//       if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200) {
//         context.read<ProductCubit>().loadMore();
//       }
//     });
//     // Check authentication status when the screen initializes
//     context.read<AuthCubit>().checkAuth();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     const maxContentWidth = 600.0;
//     final horizontalPadding = screenWidth > maxContentWidth ? 16.0 : 8.0;
//     const cardWidth = 160.0;
//     const crossAxisSpacing = 16.0;
//     final crossAxisCount = (screenWidth > maxContentWidth ? maxContentWidth : screenWidth) ~/ (cardWidth + crossAxisSpacing);
//     final adjustedCrossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

//     return Scaffold(
//       key: _scaffoldKey, // Assign the scaffold key
//       backgroundColor: Colors.transparent,
//       drawer: _buildDrawer(context), // Add the drawer
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.purple, Colors.white],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: maxContentWidth),
//               child: Column(
//                 children: [
//                   // Modified HeaderBar to include menu button functionality
//                   HeaderBar(
//                     onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(), // Open drawer on menu press
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: horizontalPadding,
//                       vertical: screenHeight * 0.015,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Products for You',
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.08 > 32 ? 32 : screenWidth * 0.08,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         SizedBox(height: screenHeight * 0.005),
//                         Text(
//                           'Discover the best trends for you',
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.04 > 16 ? 16 : screenWidth * 0.04,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: horizontalPadding,
//                       vertical: screenHeight * 0.015,
//                     ),
//                     child: TextField(
//                       controller: _search,
//                       decoration: InputDecoration(
//                         hintText: 'Search for products...',
//                         prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.8),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           borderSide: const BorderSide(color: Color(0xFF7F13EC), width: 2),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                       ),
//                       onSubmitted: (value) => context.read<ProductCubit>().search(_search.text.trim()),
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: horizontalPadding,
//                       vertical: screenHeight * 0.01,
//                     ),
//                     child: Row(
//                       children: [
//                         _buildCategoryButton('All', isSelected: true),
//                         SizedBox(width: screenWidth * 0.03),
//                         _buildCategoryButton('New Arrivals'),
//                         SizedBox(width: screenWidth * 0.03),
//                         _buildCategoryButton('Best Sellers'),
//                         SizedBox(width: screenWidth * 0.03),
//                         _buildCategoryButton('Featured'),
//                         SizedBox(width: screenWidth * 0.03),
//                         _buildCategoryButton('Sale'),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: BlocBuilder<ProductCubit, ProductState>(
//                       builder: (context, state) {
//                         if (state is ProductLoading) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//                         if (state is ProductError) {
//                           return Center(child: Text('Error: ${state.message}'));
//                         }
//                         if (state is ProductEmpty) {
//                           return const Center(child: Text('No products'));
//                         }
//                         if (state is ProductLoaded) {
//                           final items = state.products;
//                           return RefreshIndicator(
//                             onRefresh: () => context.read<ProductCubit>().refresh(),
//                             child: SingleChildScrollView(
//                               controller: _scroll,
//                               child: Column(
//                                 children: [
//                                   SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: horizontalPadding,
//                                       vertical: screenHeight * 0.015,
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         _buildFeaturedCard(
//                                           'Summer Collection',
//                                           'Explore the latest trends',
//                                           'https://lh3.googleusercontent.com/aida-public/AB6AXuBVIt5Y9ra82h6vPFebvNc7Ciq2m8tDG07KuKLf_svD3wWxlNZ2Kj82x6W0vxnIdmfjnwl4w6MAUhgE41Z3CEquo9fDatTPLh2G29LvA1XXsAK3kTbgwXbLmOZjwJinfrtC9as1iyya9Chxn0ecvXGADl0HBIrrkcp0RqIOiqq-JJKAPxCNIdMAE934jVqI8Xu5N_0sWb7tiio-qsc30Skpe-NZZEFxQd0P8-cn3kHd8ZmAh6QrHJ5S0krBK6QSV3a5olpRKF3pfbo',
//                                           screenWidth,
//                                         ),
//                                         SizedBox(width: screenWidth * 0.04),
//                                         _buildFeaturedCard(
//                                           'New Arrivals',
//                                           'Discover our newest items',
//                                           'https://lh3.googleusercontent.com/aida-public/AB6AXuAG5KVxpt0P5ycosQcVwiJy--wkTw75r0mNmeh55tUB2B5-z21FzSph5nCYXZEDJHMzX8NMLJXXaHSoNmbSxY0oSDCCtGd6rWU2y8q5ELrn5-hodZEyRn7Q3B33LNFLMvTSJUQ_Ky7YdMBOrXbxHR0bdfQwCh06y3HlFoWnywQDuT9XGLeK3HTBDK8twu_fmeWFPj9Uo8XDSciak9_XaQb1hI2SgDA37aCrB43j3VdS2UPhBLe_T02M0VJFSQnotYlkZifexuLC3t0',
//                                           screenWidth,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     constraints: const BoxConstraints(maxWidth: maxContentWidth),
//                                     child: GridView.builder(
//                                       shrinkWrap: true,
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       padding: EdgeInsets.all(horizontalPadding),
//                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: adjustedCrossAxisCount,
//                                         childAspectRatio: 0.7,
//                                         crossAxisSpacing: 16,
//                                         mainAxisSpacing: 16,
//                                       ),
//                                       itemCount: items.length + (state.hasReachedMax ? 0 : 1),
//                                       itemBuilder: (context, index) {
//                                         if (index >= items.length) {
//                                           return const Center(child: CircularProgressIndicator());
//                                         }
//                                         final p = items[index];
//                                         return GestureDetector(
//                                           onTap: () => context.go('/product/${p.id}'),
//                                           child: Container(
//                                             constraints: const BoxConstraints(
//                                               maxWidth: cardWidth,
//                                               maxHeight: cardWidth / 0.7,
//                                             ),
//                                             child: ProductCard(product: p),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }
//                         return const SizedBox.shrink();
//                       },
//                     ),
//                   ),
//                   // Moved CustomBottomNavigationBar inside the Column
//                   const CustomBottomNavigationBar(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Drawer widget
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       backgroundColor: const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8),
//       child: SafeArea(
//         child: Column(
//           children: [
//             // Drawer header with user email
//             BlocBuilder<AuthCubit, AuthState>(
//               builder: (context, state) {
//                 String email = 'Guest';
//                 if (state is AuthAuthenticated) {
//                   email = state.user.email ?? 'No email';
//                 }
//                 return UserAccountsDrawerHeader(
//                   accountName: const Text(
//                     'User',
//                     style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
//                   ),
//                   accountEmail: Text(
//                     email,
//                     style: const TextStyle(color: Colors.black54),
//                   ),
//                   decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                   ),
//                 );
//               },
//             ),
//             const Spacer(),
//             // Logout button
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     await context.read<AuthCubit>().signOut();
//                     if (!context.mounted) return;
//                     context.go('/login');
//                   } catch (e) {
//                     if (!context.mounted) return;
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Logout failed: $e')),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF7F13EC),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   minimumSize: const Size(double.infinity, 50),
//                 ),
//                 child: const Text(
//                   'Logout',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryButton(String label, {bool isSelected = false}) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         foregroundColor: isSelected ? Colors.white : Colors.grey[700],
//         backgroundColor: isSelected ? const Color(0xFF7F13EC) : Colors.white.withOpacity(0.7),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.04,
//           vertical: screenWidth * 0.02,
//         ),
//         elevation: 0,
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: screenWidth * 0.035 > 14 ? 14 : screenWidth * 0.035,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildFeaturedCard(String title, String subtitle, String imageUrl, double screenWidth) {
//     return Container(
//       width: screenWidth > 600 ? 280 : screenWidth * 0.7,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.6),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: Image.network(
//               imageUrl,
//               height: 120,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: screenWidth * 0.03),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: screenWidth * 0.045 > 18 ? 18 : screenWidth * 0.045,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           Text(
//             subtitle,
//             style: TextStyle(
//               fontSize: screenWidth * 0.035 > 14 ? 14 : screenWidth * 0.035,
//               color: Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/product/product_cubit.dart';
import '../blocs/auth/auth_cubit.dart';
import '../widgets/product_card.dart';
import 'login_screen.dart';
import '../widgets/header_bar.dart';
import '../widgets/navi_bar.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scroll = ScrollController();
  final _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200) {
        context.read<ProductCubit>().loadMore();
      }
    });
    context.read<AuthCubit>().checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const maxContentWidth = 600.0;
    final horizontalPadding = screenWidth > maxContentWidth ? 16.0 : 8.0;
    const cardWidth = 160.0;
    const crossAxisSpacing = 16.0;
    final crossAxisCount = (screenWidth > maxContentWidth ? maxContentWidth : screenWidth) ~/ (cardWidth + crossAxisSpacing);
    final adjustedCrossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit'),
                ),
              ],
            ),
          );
          if (shouldExit == true) {
            // Allow app to exit
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: _buildDrawer(context),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  children: [
                    HeaderBar(
                      onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: screenHeight * 0.015,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Products for You',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08 > 32 ? 32 : screenWidth * 0.08,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255)                          ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            'Discover the best trends for you',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04 > 16 ? 16 : screenWidth * 0.04,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: screenHeight * 0.015,
                      ),
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: 'Search for products...',
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Color(0xFF7F13EC), width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onSubmitted: (value) => context.read<ProductCubit>().search(_search.text.trim()),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Row(
                        children: [
                          _buildCategoryButton('All', isSelected: true),
                          SizedBox(width: screenWidth * 0.03),
                          _buildCategoryButton('New Arrivals'),
                          SizedBox(width: screenWidth * 0.03),
                          _buildCategoryButton('Best Sellers'),
                          SizedBox(width: screenWidth * 0.03),
                          _buildCategoryButton('Featured'),
                          SizedBox(width: screenWidth * 0.03),
                          _buildCategoryButton('Sale'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          if (state is ProductLoading) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (state is ProductError) {
                            return Center(child: Text('Error: ${state.message}'));
                          }
                          if (state is ProductEmpty) {
                            return const Center(child: Text('No products'));
                          }
                          if (state is ProductLoaded) {
                            final items = state.products;
                            return RefreshIndicator(
                              onRefresh: () => context.read<ProductCubit>().refresh(),
                              child: SingleChildScrollView(
                                controller: _scroll,
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: horizontalPadding,
                                        vertical: screenHeight * 0.015,
                                      ),
                                      child: Row(
                                        children: [
                                          _buildFeaturedCard(
                                            'Summer Collection',
                                            'Explore the latest trends',
                                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBVIt5Y9ra82h6vPFebvNc7Ciq2m8tDG07KuKLf_svD3wWxlNZ2Kj82x6W0vxnIdmfjnwl4w6MAUhgE41Z3CEquo9fDatTPLh2G29LvA1XXsAK3kTbgwXbLmOZjwJinfrtC9as1iyya9Chxn0ecvXGADl0HBIrrkcp0RqIOiqq-JJKAPxCNIdMAE934jVqI8Xu5N_0sWb7tiio-qsc30Skpe-NZZEFxQd0P8-cn3kHd8ZmAh6QrHJ5S0krBK6QSV3a5olpRKF3pfbo',
                                            screenWidth,
                                          ),
                                          SizedBox(width: screenWidth * 0.04),
                                          _buildFeaturedCard(
                                            'New Arrivals',
                                            'Discover our newest items',
                                            'https://lh3.googleusercontent.com/aida-public/AB6AXuAG5KVxpt0P5ycosQcVwiJy--wkTw75r0mNmeh55tUB2B5-z21FzSph5nCYXZEDJHMzX8NMLJXXaHSoNmbSxY0oSDCCtGd6rWU2y8q5ELrn5-hodZEyRn7Q3B33LNFLMvTSJUQ_Ky7YdMBOrXbxHR0bdfQwCh06y3HlFoWnywQDuT9XGLeK3HTBDK8twu_fmeWFPj9U8XDSciak9_XaQb1hI2SgDA37aCrB43j3VdS2UPhBLe_T02M0VJFSQnotYlkZifexuLC3t0',
                                            screenWidth,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: maxContentWidth),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.all(horizontalPadding),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: adjustedCrossAxisCount,
                                          childAspectRatio: 0.7,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                        ),
                                        itemCount: items.length + (state.hasReachedMax ? 0 : 1),
                                        itemBuilder: (context, index) {
                                          if (index >= items.length) {
                                            return const Center(child: CircularProgressIndicator());
                                          }
                                          final p = items[index];
                                          return GestureDetector(
                                            onTap: () => context.push('/product/${p.id}'), // Use push to maintain stack
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                maxWidth: cardWidth,
                                                maxHeight: cardWidth / 0.7,
                                              ),
                                              child: ProductCard(product: p),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    const CustomBottomNavigationBar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 243, 217, 248).withOpacity(0.8),
      child: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                String email = 'Guest';
                if (state is AuthAuthenticated) {
                  email = state.user.email ?? 'No email';
                }
                return UserAccountsDrawerHeader(
                  accountName: const Text(
                    'User',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    email,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                );
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await context.read<AuthCubit>().signOut();
                    if (!context.mounted) return;
                    context.go('/login');
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F13EC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String label, {bool isSelected = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.grey[700],
        backgroundColor: isSelected ? const Color(0xFF7F13EC) : Colors.white.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.02,
        ),
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.035 > 14 ? 14 : screenWidth * 0.035,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String subtitle, String imageUrl, double screenWidth) {
    return Container(
      width: screenWidth > 600 ? 280 : screenWidth * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045 > 18 ? 18 : screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: screenWidth * 0.035 > 14 ? 14 : screenWidth * 0.035,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}