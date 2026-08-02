import "package:flutter/material.dart";
import "package:how_is_your_faith/src/ui/widgets/home/last_activity_card.dart";
import "package:how_is_your_faith/src/utils/styles/themes/devotional_theme.dart";
import "package:how_is_your_faith/src/ui/widgets/home/verse_card.dart";
import "package:how_is_your_faith/src/utils/vars.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:how_is_your_faith/src/controllers/bible_vers_controller.dart";

final List<Map<String, dynamic>> devotionalModels = [
  {
    "coverUrl":
        "https://images.unsplash.com/photo-1504052434569-70ad5836ab65?auto=format&fit=crop&w=900&q=80",
    "title": "Esperança para tempos difíceis",
    "estimatedCompletion": "5 dias",
  },
  {
    "coverUrl":
        "https://images.unsplash.com/photo-1507692049790-de58290a4334?auto=format&fit=crop&w=900&q=80",
    "title": "Paz que excede todo entendimento",
    "estimatedCompletion": "7 dias",
  },
  {
    "coverUrl":
        "https://images.unsplash.com/photo-1502134249126-9f3755a50d78?auto=format&fit=crop&w=900&q=80",
    "title": "Comece bem seu dia",
    "estimatedCompletion": "3 dias",
  },
];

class Start extends StatelessWidget {
  Start({super.key});
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
        child: ListView(
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            // Aqui ficará um card com o versículo do dia, ou algo do tipo para incentivar o usuário a usar o app diariamente
            FutureBuilder<Map<String, dynamic>>(
              future: BibleVersController.getTodayVerse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
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
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(
                "Continue de onde parou",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            LastActivityCard(
              theme: DevotionalColors(),
              title: "Fortalecendo sua Fé",
              status: "Em Andamento",
              progress: 0.33,
              step: 7,
              totalSteps: 25,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(
                "Devocionais recomendados",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: devotionalModels.length,
                itemBuilder: (context, index) {
                  final devotional = devotionalModels[index];
                  return Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(devotional["coverUrl"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              devotional["title"]!,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            devotional["estimatedCompletion"]!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
