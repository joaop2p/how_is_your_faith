import 'package:flutter/material.dart';
import 'package:how_is_your_faith/src/ui/pages/views/init.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Start(),
    Center(child: Text("Search Page")),
    Center(child: Text("Profile Page")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Start',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Bíblia'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Devocional',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          // BottomNavigationBarItem,
        ],
      ),
    );
  }
}
