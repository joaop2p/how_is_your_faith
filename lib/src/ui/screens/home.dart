import "package:flutter/material.dart";
import "package:how_is_your_faith/src/styles/themes/devotional_theme.dart";
import "package:how_is_your_faith/src/ui/widgets/home/verse_card.dart";
import "package:how_is_your_faith/src/utils/vars.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:how_is_your_faith/src/controllers/bible_vers_controller.dart";

class Home extends StatelessWidget {
  Home({super.key});
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
                    //
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
            //TODO: espaço reservado para os indicadores do usuário, como progresso de leitura da bíblia, progresso de oração, etc.
            const SizedBox(height: 5),
            Container(height: 100, color: Colors.white),
            const SizedBox(height: 10),
            // Container(
            //   // height: 150,
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   alignment: Alignment.centerLeft,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Continue de onde parou",
            //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //         textAlign: TextAlign.left,
            //       ),
            //       SizedBox(height: 5),
            //       Container(
            //         padding: EdgeInsets.all(8.0),
            //         // height: 100,
            //         // height: ,
            //         decoration: BoxDecoration(
            //           color: Color.fromARGB(255, 240, 240, 240),
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: Row(
            //           children: [
            //             SizedBox(width: 10),
            //             // Ícone da atividade
            //             Container(
            //               height: 60,
            //               width: 60,
            //               padding: EdgeInsets.only(left: 3.0, top: 8.0, right: 3.0, bottom: 8.0),
            //               decoration: BoxDecoration(
            //                 color: Color.fromARGB(255, 255, 255, 255),
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //               child: Icon(
            //                 Icons.menu_book,
            //                 color: Color(0xFFD6AE6C),
            //                 size: 40,
            //               ),
            //             ),
            //             SizedBox(width: 10),
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 //Titulo da atividade
            //                 Text(
            //                   "Plano Devocional",
            //                   style: TextStyle(
            //                     fontSize: 13,
            //                     fontWeight: FontWeight.bold,
            //                     color: Color(0xFF9AB882),
            //                   ),
            //                 ),
            //                 SizedBox(height: 4),
            //                 // Descrição da atividade
            //                 Text(
            //                   "Fortalecendo a sua Fé",
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                     color: Color.fromARGB(255, 76, 76, 76),
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 Text(
            //                   "Dia 3 de 30 - 33% concluído",
            //                   style: TextStyle(
            //                     fontSize: 14,
            //                     color: Color.fromARGB(255, 76, 76, 76),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width:
            //                       150, // ou MediaQuery.of(context).size.width * 0.6
            //                   child: LinearProgressIndicator(
            //                     value: 0.33,
            //                     backgroundColor: Color.fromARGB(
            //                       255,
            //                       240,
            //                       240,
            //                       240,
            //                     ),
            //                     valueColor: AlwaysStoppedAnimation<Color>(
            //                       Color(0xFFD6AE6C),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Spacer(),
            //             Container(
            //               alignment: Alignment.bottomRight,
            //               child: ElevatedButton(
            //                 onPressed: () {
            //                   // Ação ao clicar no botão
            //                 },
            //                 style: ElevatedButton.styleFrom(
            //                   backgroundColor: Color(0xFFD6AE6C),
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(8),
            //                   ),
            //                 ),
            //                 child: Text(
            //                   "Continuar",
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 14,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                
            
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Continue de onde parou",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C1C1C),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: DevotionalColors.light,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // spacing: 16,
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: DevotionalColors.dark.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.menu_book_rounded,
                            color: DevotionalColors.primary,
                            size: 32,
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            // spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Em Andamento",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  // letterSpacing: 1,
                                  color: DevotionalColors.primary,
                                ),
                              ),
                              Text(
                                "Fortalecendo sua Fé",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromARGB(255, 42, 42, 42),
                                ),
                              ),
                              Text(
                                "Dia 7 de 21 • 33% concluído",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: DevotionalColors.accent,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                                width: double.infinity,
                                child:ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: 0.33,
                                    backgroundColor: DevotionalColors.light,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      DevotionalColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Spacer(),
                        SizedBox(
                          child: IconButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              color: DevotionalColors.dark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
