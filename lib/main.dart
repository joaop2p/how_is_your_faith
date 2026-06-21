import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'src/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  await Supabase.initialize(
    url: dotenv.env['API_URL']!,
    publishableKey: dotenv.env['ANON_KEY']!,
  );
  runApp(const App());
}
