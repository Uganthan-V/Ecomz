
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'presentation/screens/login_screen.dart';
// // // import 'presentation/screens/product_list_screen.dart';
// // // import 'presentation/blocs/auth/auth_cubit.dart';
// // // import 'presentation/blocs/product/product_cubit.dart';
// // // import 'presentation/blocs/cart/cart_cubit.dart';
// // // import 'presentation/blocs/wishlist/wishlist_cubit.dart';
// // // import 'data/datasources/product_remote_datasource.dart';
// // // import 'data/datasources/local_storage.dart';
// // // import 'data/repositories/product_repository_impl.dart';
// // // import 'package:dio/dio.dart';

// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final dio = Dio();
// // //     final remote = ProductRemoteDataSourceImpl(dio);
// // //     final local = LocalStorageService();
// // //     final repo = ProductRepositoryImpl(remote: remote, local: local);

// // //     return MultiBlocProvider(
// // //       providers: [
// // //         BlocProvider(create: (_) => AuthCubit()..checkAuth()),
// // //         BlocProvider(create: (_) => ProductCubit(repo: repo)..fetchInitial()),
// // //         BlocProvider(create: (_) => CartCubit(localStorage: local)..loadFromStorage()),
// // //         BlocProvider(create: (_) => WishlistCubit(localStorage: local)..loadFromStorage()),
// // //       ],
// // //       child: BlocBuilder<AuthCubit, AuthState>(
// // //         builder: (context, authState) {
// // //           return MaterialApp(
// // //             debugShowCheckedModeBanner: false,
// // //             title: 'E-Commerce Mini',
// // //             theme: ThemeData(
// // //               primarySwatch: Colors.purple,
// // //               brightness: Brightness.light,
// // //             ),
// // //             home: authState is AuthAuthenticated
// // //                 ? const ProductListScreen()
// // //                 : const LoginScreen(),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'presentation/screens/login_screen.dart';
// // import 'presentation/screens/product_list_screen.dart';
// // import 'presentation/blocs/auth/auth_cubit.dart';
// // import 'presentation/blocs/product/product_cubit.dart';
// // import 'presentation/blocs/cart/cart_cubit.dart';
// // import 'presentation/blocs/wishlist/wishlist_cubit.dart';
// // import 'data/datasources/product_remote_datasource.dart';
// // import 'data/datasources/local_storage.dart';
// // import 'data/repositories/product_repository_impl.dart';
// // import 'package:dio/dio.dart';

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Set transparent status bar
// //     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
// //       statusBarColor: Colors.transparent,
// //       statusBarIconBrightness: Brightness.dark, // For dark icons on light background
// //     ));

// //     final dio = Dio();
// //     final remote = ProductRemoteDataSourceImpl(dio);
// //     final local = LocalStorageService();
// //     final repo = ProductRepositoryImpl(remote: remote, local: local);

// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider(create: (_) => AuthCubit()..checkAuth()),
// //         BlocProvider(create: (_) => ProductCubit(repo: repo)..fetchInitial()),
// //         BlocProvider(create: (_) => CartCubit(localStorage: local)..loadFromStorage()),
// //         BlocProvider(create: (_) => WishlistCubit(localStorage: local)..loadFromStorage()),
// //       ],
// //       child: BlocBuilder<AuthCubit, AuthState>(
// //         builder: (context, authState) {
// //           return MaterialApp(
// //             debugShowCheckedModeBanner: false,
// //             title: 'E-Commerce Mini',
// //             theme: ThemeData(
// //               primarySwatch: Colors.purple,
// //               brightness: Brightness.light,
// //             ),
// //             home: SafeArea(
// //               child: authState is AuthAuthenticated
// //                   ? const ProductListScreen()
// //                   : const LoginScreen(),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'presentation/screens/login_screen.dart';
// import 'presentation/screens/register_screen.dart';
// import 'presentation/screens/product_list_screen.dart';
// import 'presentation/screens/product_detail_screen.dart';
// import 'presentation/screens/cart_screen.dart';
// import 'presentation/screens/wishlist_screen.dart';
// import 'presentation/blocs/auth/auth_cubit.dart';
// import 'presentation/blocs/product/product_cubit.dart';
// import 'presentation/blocs/cart/cart_cubit.dart';
// import 'presentation/blocs/wishlist/wishlist_cubit.dart';
// import 'data/datasources/product_remote_datasource.dart';
// import 'data/datasources/local_storage.dart';
// import 'data/repositories/product_repository_impl.dart';
// import 'package:dio/dio.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dio = Dio();
//     final remote = ProductRemoteDataSourceImpl(dio);
//     final local = LocalStorageService();
//     final repo = ProductRepositoryImpl(remote: remote, local: local);

//     // Define GoRouter configuration
//     final GoRouter router = GoRouter(
//       initialLocation: '/login',
//       routes: [
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginScreen(),
//         ),
//         GoRoute(
//           path: '/register',
//           builder: (context, state) => const RegisterScreen(),
//         ),
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const ProductListScreen(),
//         ),
//         GoRoute(
//           path: '/product/:id',
//           builder: (context, state) {
//             final id = int.parse(state.pathParameters['id']!);
//             return ProductDetailScreen(productId: id);
//           },
//         ),
//         GoRoute(
//           path: '/cart',
//           builder: (context, state) => const CartScreen(),
//         ),
//         GoRoute(
//           path: '/wishlist',
//           builder: (context, state) => const WishlistScreen(),
//         ),
//       ],
//       redirect: (BuildContext context, GoRouterState state) {
//         final authCubit = context.read<AuthCubit>();
//         final isAuthenticated = authCubit.state is AuthAuthenticated;

//         // Redirect to login if not authenticated and trying to access protected routes
//         if (!isAuthenticated && state.matchedLocation != '/login' && state.matchedLocation != '/register') {
//           return '/login';
//         }
//         // Redirect to home if authenticated and trying to access login/register
//         if (isAuthenticated && (state.matchedLocation == '/login' || state.matchedLocation == '/register')) {
//           return '/';
//         }
//         return null;
//       },
//     );

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => AuthCubit()..checkAuth()),
//         BlocProvider(create: (_) => ProductCubit(repo: repo)..fetchInitial()),
//         BlocProvider(create: (_) => CartCubit(localStorage: local)..loadFromStorage()),
//         BlocProvider(create: (_) => WishlistCubit(localStorage: local)..loadFromStorage()),
//       ],
//       child: MaterialApp.router(
//         debugShowCheckedModeBanner: false,
//         title: 'E-Commerce Mini',
//         theme: ThemeData(
//           primarySwatch: Colors.purple,
//           brightness: Brightness.light,
//         ),
//         routerConfig: router,
//       ),
//     );
//   }
// }

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar to transparent with light icons for visibility
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Light icons for purple gradient
      statusBarBrightness: Brightness.dark, // For iOS compatibility
    ));

    final dio = Dio();
    final remote = ProductRemoteDataSourceImpl(dio);
    final local = LocalStorageService();
    final repo = ProductRepositoryImpl(remote: remote, local: local);

    // Define GoRouter configuration
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

        // Redirect to login if not authenticated and trying to access protected routes
        if (!isAuthenticated &&
            state.matchedLocation != '/login' &&
            state.matchedLocation != '/register') {
          return '/login';
        }
        // Redirect to home if authenticated and trying to access login/register
        if (isAuthenticated &&
            (state.matchedLocation == '/login' ||
                state.matchedLocation == '/register')) {
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
      ],
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce Mini',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            brightness: Brightness.light,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black87),
            ),
          ),
          routerConfig: router,
          builder: (context, child) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              body: child ?? const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}