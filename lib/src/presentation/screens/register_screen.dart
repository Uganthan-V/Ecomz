
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_cubit.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirmPass = TextEditingController();

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

  bool _doPasswordsMatch() {
    return _pass.text.trim() == _confirmPass.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.read<AuthCubit>().state is! AuthAuthenticated,
      onPopInvoked: (didPop) {
        if (!didPop && context.read<AuthCubit>().state is AuthAuthenticated) {
          context.go('/');
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
                      'Ecomz',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Match text color to gradient
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcomes you',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email, color: Colors.white70),
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
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPass,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                        hintText: 'Confirm Password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthAuthenticated) {
                          context.go('/login');
                        }
                        if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) return const CircularProgressIndicator();
                        return ElevatedButton(
                          onPressed: () {
                            if (!_doPasswordsMatch()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passwords do not match')),
                              );
                              return;
                            }
                            context.read<AuthCubit>().register(
                                  _email.text.trim(),
                                  _pass.text.trim(),
                                );
                          },
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
                            'SIGN UP',
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _confirmPass.dispose();
    super.dispose();
  }
}