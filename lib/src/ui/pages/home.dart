import "dart:math" as math;

import "package:flutter/material.dart";
import "package:how_is_your_faith/src/utils/vars.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:how_is_your_faith/src/controllers/bible_vers_controller.dart";

class Home extends StatelessWidget {
  Home({super.key});
  final String userName = "Usuário";
  final User user = Supabase.instance.client.auth.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo_app.png",
                    height: 50,
                    width: 50,
                  ),
                  SizedBox(
                    width: 100,
                    child: const Text(
                      GlobalVars.appName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color.fromARGB(124, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                    ),
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, ${user.userMetadata?['full_name']?.toString().split(' ').first ?? 'Usuário'}. 👋',
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Como está a sua fé hoje?',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 76, 76, 76),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Aqui ficará um card com o versículo do dia, ou algo do tipo para incentivar o usuário a usar o app diariamente
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/home/banner.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.0),
                        alignment: Alignment.centerLeft,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(58, 171, 169, 246),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu_book_sharp,
                              color: Color.fromARGB(255, 146, 144, 252),
                              size: 16,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Versículo do dia',
                              style: TextStyle(
                                color: Color.fromARGB(255, 146, 144, 252),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: Icon(
                          Icons.format_quote,
                          color: Color.fromARGB(255, 146, 144, 252),
                          size: 40,
                        ),
                      ),

                      // SizedBox(height: 10),
                      FutureBuilder<String>(
                        future: BibleVersController.getBibleVerse(
                          "john",
                          3,
                          16,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erro ao carregar o versículo');
                          } else {
                            return Text(
                              snapshot.data ?? 'Versículo não encontrado.',
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                          }
                        },
                      ),
                      Text(
                        'João 3:16',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 146, 144, 252),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Text(
                  "Sua jornada da fé",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                      Color.fromARGB(255, 146, 144, 252),
                    ),
                    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 14)),
                  ),
                  child: Row(
                    children: [
                      Text("Ver tudo"),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
