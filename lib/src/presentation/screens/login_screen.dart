
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'product_list_screen.dart';
import '../blocs/auth/auth_cubit.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set transparent status bar with light icons
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Light icons for gradient
      statusBarBrightness: Brightness.dark, // iOS specific
    ));
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.read<AuthCubit>().state is! AuthAuthenticated, // Allow pop if unauthenticated
      onPopInvoked: (didPop) {
        if (!didPop && context.read<AuthCubit>().state is AuthAuthenticated) {
          context.go('/'); // Navigate to home if authenticated
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true, // Allow gradient to extend under status bar
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            top: false, // Allow content to extend under status bar
            bottom: true,
            maintainBottomViewPadding: true,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome baaaaaaack!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Match text color to gradient
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Log in to existing account',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.white70),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2), // Semi-transparent input
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixText: 'Forgot Password?',
                        suffixStyle: const TextStyle(color: Colors.blue),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          context.go('/');
                        }
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(state.message)));
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) return const CircularProgressIndicator();
                        return ElevatedButton(
                          onPressed: () => context.read<AuthCubit>().signIn(
                                _email.text.trim(),
                                _pass.text.trim(),
                              ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 184, 98, 199),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 100,
                              vertical: 15,
                            ),
                          ),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Or sign up using',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset('assets/facebook.png', width: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/google.png', width: 30),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Image.asset('assets/apple.png', width: 30),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}