import 'package:flutter/material.dart';
import 'ui/pages/auth.dart';

class App extends StatelessWidget {

  const App({super.key});

  static const String title = 'How is your faith?';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Auth(),
    );
  }
}