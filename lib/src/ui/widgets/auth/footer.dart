import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        color: const Color.fromARGB(255, 82, 111, 241).withValues(alpha: 0.1),
        child: Center(
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '"Entrega o teu caminho ao Senhor; confia nele, e ele tudo fará."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.6),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Salmos 37:5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ao continuar, você concorda com os nossos termos de uso e política de privacidade.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                // const SizedBox(height: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Termos de uso e política de privacidade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(
                        255,
                        164,
                        144,
                        252,
                      ).withValues(alpha: 0.8),
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // começa no canto superior esquerdo, mas deslocado para baixo
    path.moveTo(0, 80);

    // curva na parte superior
    path.cubicTo(
      size.width * 0.25,
      -20, // CP1: sobe acima do container
      size.width * 0.75,
      100, // CP2: desce abaixo do início
      size.width,
      40, // termina no lado direito
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}
