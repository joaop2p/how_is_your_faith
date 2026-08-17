import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:how_is_your_faith/src/core/autenticator/google_auth_service.dart';

class AuthController {
  AuthController({SupabaseClient? client, GoogleAuthService? googleAuthService})
    : _supabase = client ?? Supabase.instance.client,
      _googleAuthService = googleAuthService ?? GoogleAuthService();

  final SupabaseClient _supabase;
  final GoogleAuthService _googleAuthService;

  User? get currentUser => _supabase.auth.currentUser;

  Session? get currentSession => _supabase.auth.currentSession;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<void> signInWithGoogle() async {
    await _googleAuthService.signInWithGoogleNative();
  }
}
