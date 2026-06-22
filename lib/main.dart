import 'package:flutter/material.dart';
import 'package:how_is_your_faith/src/ui/pages/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['PUBLIC_KEY']!,
  );
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final session = data.session;
    if (session != null) {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (_) => Home()),
      );
    }
  });
  runApp(const App());
}
