import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  AuthController({SupabaseClient? client})
    : _supabase = client ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  User? get currentUser => _supabase.auth.currentUser;

  Session? get currentSession => _supabase.auth.currentSession;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    return _supabase.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<bool> signInWithGoogle() async {
   return await _supabase.auth.signInWithOAuth(
     OAuthProvider.google,
     redirectTo: kIsWeb ? null : 'io.supabase.flutter://login-callback/',
   );
  }

  Future<void> signOut() {
    return _supabase.auth.signOut();
  }
}
