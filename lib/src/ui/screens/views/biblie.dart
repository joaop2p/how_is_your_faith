import 'package:flutter/material.dart';
import 'package:how_is_your_faith/src/ui/widgets/bible/books_by_testament_view.dart';

class BibleScreen extends StatelessWidget {
  const BibleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.0),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF4F6FB),
                const Color.fromARGB(46, 170, 166, 252),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bíblia",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        foregroundColor: const Color(0xFF907DC2),
                        shadowColor: Colors.black.withOpacity(0.1),
                        backgroundColor: const Color.fromARGB(
                          124,
                          255,
                          255,
                          255,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                      icon: Icon(Icons.filter_list),
                    ),
                    SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        foregroundColor: const Color(0xFF907DC2),
                        shadowColor: Colors.black.withOpacity(0.1),
                        backgroundColor: const Color.fromARGB(
                          124,
                          255,
                          255,
                          255,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(5),
                      ),
                      icon: Icon(Icons.bookmark_border),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar na Bíblia',
                    hintStyle: const TextStyle(
                      color: Color(0xFF8E95A3),
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 18, right: 12),
                      child: Icon(
                        Icons.search_rounded,
                        color: Color(0xFF8E95A3),
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    fillColor: const Color.fromARGB(50, 197, 197, 197),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: 'Antigo Testamento'),
                    Tab(text: 'Novo Testamento'),
                  ],
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xFF8B85E8),
                  indicatorWeight: 2.4,
                  labelColor: const Color(0xFF7C75D8),
                  unselectedLabelColor: const Color(0xFF6F7480),
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
              ),
              Expanded(
                child: Container(
                  // height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TabBarView(
                    children: [
                      BooksByTestamentView(testament: 'old'),
                      BooksByTestamentView(testament: 'new'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
