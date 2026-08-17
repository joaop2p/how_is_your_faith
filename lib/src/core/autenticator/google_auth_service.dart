import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _googleSignIn.initialize(
      serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID'],
    );
    _initialized = true;
  }

  /// Abre a UI nativa de seleção de conta Google e autentica no Supabase.
  Future<void> signInWithGoogleNative() async {
    await _ensureInitialized();

    final GoogleSignInAccount account = await _googleSignIn.authenticate();

    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw Exception('Google não retornou idToken');
    }

    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await Supabase.instance.client.auth.signOut();
  }
}
