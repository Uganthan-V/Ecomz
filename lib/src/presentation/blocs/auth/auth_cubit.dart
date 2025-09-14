
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user.uid];
}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> checkAuth() async {
    final user = _auth.currentUser;
    if (user != null) emit(AuthAuthenticated(user));
    else emit(AuthUnauthenticated());
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(AuthAuthenticated(cred.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      emit(AuthAuthenticated(cred.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(AuthUnauthenticated());
  }
}