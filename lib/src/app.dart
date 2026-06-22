import 'package:flutter/material.dart';
import 'package:how_is_your_faith/main.dart';
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
      navigatorKey: navigatorKey,
      home: Auth(),
    );
  }
}