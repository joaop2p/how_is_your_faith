import "package:flutter/material.dart";
import 'package:how_is_your_faith/src/controllers/auth_controller.dart';
import 'package:how_is_your_faith/src/ui/pages/home.dart';
import 'package:how_is_your_faith/src/ui/widgets/home/banner.dart';
import 'package:how_is_your_faith/src/ui/widgets/home/cards.dart';
import 'package:how_is_your_faith/src/ui/widgets/home/footer.dart';

class Auth extends StatelessWidget {
  Auth({super.key});

  final List<Map<String, Object>> cards = [
    {
      'label': 'Conecte-se com Deus',
      'img': 'assets/images/auth/purple_icon.svg',
      'subtitle': 'Registre suas orações e momentos especiais.',
      'textColor': const Color.fromARGB(255, 19, 17, 53),
      'foregroundColor': const Color.fromARGB(255, 92, 81, 248),
    },
    {
      'label': 'Cresça diariamente',
      'img': 'assets/images/auth/green_icon.svg',
      'subtitle': 'Acompanhe sua leitura bíblica e aprendizados.',
      'textColor': const Color.fromARGB(255, 14, 77, 14),
      'foregroundColor': const Color.fromARGB(255, 29, 161, 29),
    },
    {
      'label': 'Veja a evolução',
      'img': 'assets/images/auth/yellow_icon.svg',
      'subtitle': 'Perceba como sua fé se fortalece com o passar do tempo.',
      'textColor': const Color.fromARGB(255, 151, 106, 23),
      'foregroundColor': const Color.fromARGB(255, 243, 170, 33),
    },
  ];

  void simulateLogin(BuildContext context) {
    // Simula um processo de login
    Future.delayed(const Duration(seconds: 2), () {
      // Após o delay, navega para a próxima tela ou exibe uma mensagem de sucesso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    // Simula um processo de login com Google
    AuthController authController = AuthController();
    bool success = await authController.signInWithGoogle();
    if (success) {
      // Se o login for bem-sucedido, navega para a próxima tela
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      // Se o login falhar, exibe uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao fazer login com Google.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AuthBanner(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: cards
                .map(
                  (card) => Cards(
                    label: card['label'] as String,
                    img: card['img'] as String,
                    subtitle: card['subtitle'] as String,
                    textColor: card['textColor'] as Color,
                    foregroundColor: card['foregroundColor'] as Color,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => simulateLogin(context),
            style: ElevatedButton.styleFrom(
              maximumSize: Size(MediaQuery.of(context).size.width - 40, 50),
              backgroundColor: const Color.fromARGB(255, 9, 22, 37),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515358_10512.png',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Continuar com Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 16,
                color: Colors.black..withValues(alpha:0.6),
              ),
              const SizedBox(width: 8),
              Text(
                'Suas informações estão seguras conosco.',
                style: TextStyle(
                  color: Colors.black..withValues(alpha:0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Expanded(
            child: Footer(),
          ),
        ],
      ),
    );
  }
}

