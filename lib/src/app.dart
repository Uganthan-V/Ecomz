
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/register_screen.dart';
import 'presentation/screens/product_list_screen.dart';
import 'presentation/screens/product_detail_screen.dart';
import 'presentation/screens/cart_screen.dart';
import 'presentation/screens/wishlist_screen.dart';
import 'presentation/blocs/auth/auth_cubit.dart';
import 'presentation/blocs/product/product_cubit.dart';
import 'presentation/blocs/cart/cart_cubit.dart';
import 'presentation/blocs/wishlist/wishlist_cubit.dart';
import 'data/datasources/product_remote_datasource.dart';
import 'data/datasources/local_storage.dart';
import 'data/repositories/product_repository_impl.dart';
import 'package:dio/dio.dart';
import 'presentation/blocs/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final remote = ProductRemoteDataSourceImpl(dio);
    final local = LocalStorageService();
    final repo = ProductRepositoryImpl(remote: remote, local: local);

    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const ProductListScreen(),
        ),
        GoRoute(
          path: '/product/:id',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id']!);
            return ProductDetailScreen(productId: id);
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
        GoRoute(
          path: '/wishlist',
          builder: (context, state) => const WishlistScreen(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final authCubit = context.read<AuthCubit>();
        final isAuthenticated = authCubit.state is AuthAuthenticated;

        if (!isAuthenticated && state.matchedLocation != '/login' && state.matchedLocation != '/register') {
          return '/login';
        }
        if (isAuthenticated && (state.matchedLocation == '/login' || state.matchedLocation == '/register')) {
          return '/';
        }
        return null;
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()..checkAuth()),
        BlocProvider(create: (_) => ProductCubit(repo: repo)..fetchInitial()),
        BlocProvider(create: (_) => CartCubit(localStorage: local)..loadFromStorage()),
        BlocProvider(create: (_) => WishlistCubit(localStorage: local)..loadFromStorage()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce Mini',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.black87),
                bodyMedium: TextStyle(color: Colors.black87),
                titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              iconTheme: const IconThemeData(color: Colors.grey),
              cardTheme: CardThemeData(
                color: Colors.white.withOpacity(0.8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[800],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white70),
                titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              iconTheme: const IconThemeData(color: Colors.white70),
              cardTheme: CardThemeData(
                color: Colors.grey[850]!.withOpacity(0.8),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            themeMode: themeMode,
            routerConfig: router,
          );
        },
      ),
    );
  }
}