import "package:flutter/material.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/home/banner.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
