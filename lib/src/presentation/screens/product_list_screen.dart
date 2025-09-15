
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/product/product_cubit.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/theme/theme_cubit.dart';
import '../widgets/product_card.dart';
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
              title: Text(
                'Exit App',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge!.color),
              ),
              content: Text(
                'Are you sure you want to exit the app?',
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Exit',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          );
          if (shouldExit == true) {
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: _buildDrawer(context),
        body: Container(
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
                              color: Theme.of(context).textTheme.titleLarge!.color,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            'Discover the best trends for you',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04 > 16 ? 16 : screenWidth * 0.04,
                              color: Theme.of(context).textTheme.bodyMedium!.color,
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
                          prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
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
                            return Center(
                              child: Text(
                                'Error: ${state.message}',
                                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                              ),
                            );
                          }
                          if (state is ProductEmpty) {
                            return Center(
                              child: Text(
                                'No products',
                                style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                              ),
                            );
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
                                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBVIt5Y9ra82h6vPFebvNc7Ciq2m8tDG07KuKLf_svD3wWxlNZ2Kj82x6W0vxnIdmfjnwl4w6MAUhgE41Z3CEquo9fDatTPLh2G29LvA1XXsAK3kTbgwXbLmOZjwJinfrtC9as1iyya9Chxn0ecvXGADl0HBIrrkcp0RqIOiqq-JJKAPxCNIdMAE934jVqI8Xu5N_0sWb7tiio-qsc30Skpe-NZZEFxQd0P8-cn3kHd8ZmAh6QrHJ5S0krBK6QSV3a5olpRKF3pfbo',

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
                                            onTap: () => context.push('/product/${p.id}'),
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
      backgroundColor: Theme.of(context).cardTheme.color,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Theme',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge!.color,
                    ),
                  ),
                  BlocBuilder<ThemeCubit, ThemeMode>(
                    builder: (context, themeMode) {
                      return Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        activeColor: Theme.of(context).primaryColorDark,
                        inactiveThumbColor: Theme.of(context).primaryColor,
                        activeTrackColor: Theme.of(context).primaryColorLight,
                        inactiveTrackColor: Theme.of(context).iconTheme.color,
                        thumbIcon: WidgetStateProperty.all(
                          Icon(
                            themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
                            color: Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                String email = 'Guest';
                if (state is AuthAuthenticated) {
                  email = state.user.email ?? 'No email';
                }
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    'User',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleLarge!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
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
                      SnackBar(
                        content: Text(
                          'Logout failed: $e',
                          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                  foregroundColor: Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({}),
                  ),
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
        foregroundColor: isSelected
            ? Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({})
            : Theme.of(context).textTheme.bodyMedium!.color,
        backgroundColor: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardTheme.color,
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
          color: isSelected
              ? Theme.of(context).elevatedButtonTheme.style!.foregroundColor!.resolve({})
              : Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String subtitle, String imageUrl, double screenWidth) {
    return Container(
      width: screenWidth > 600 ? 280 : screenWidth * 0.7,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
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
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.image_not_supported, color: Theme.of(context).iconTheme.color),
            ),
          ),
          SizedBox(height: screenWidth * 0.03),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045 > 18 ? 18 : screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: screenWidth * 0.035 > 14 ? 14 : screenWidth * 0.035,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}