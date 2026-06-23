
import "package:flutter/material.dart";
import "package:how_is_your_faith/src/ui/widgets/home/verse_card.dart";
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
            FutureBuilder<Map<String, dynamic>>(
              future: BibleVersController.getTodayVerse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  debugPrint('Erro ao carregar versículo: ${snapshot.error}');
                  return const Text('Não foi possível carregar o versículo.');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('Nenhum versículo encontrado.');
                } else {
                  final verseData = snapshot.data!;
                  final verseText = verseData['text'] ?? '';
                  final verseReference = verseData['reference'] ?? '';
                  return VerseCard(verse: verseText, reference: verseReference);
                }
              },
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
