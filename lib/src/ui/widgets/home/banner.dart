import 'package:flutter/material.dart';

class AuthBanner extends StatelessWidget {
  const AuthBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: SizedBox(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height * 0.40,
        height: 310,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/auth/banner.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              // color: Colors.black.withOpacity(0.3),
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(left: 24, bottom: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 255, 255, 255),
                    const Color.fromARGB(255, 255, 255, 255).withValues(alpha: 0.6),
                    // const Color.fromARGB(
                    //   255,
                    //   255,
                    //   255,
                    //   255,
                    // ).withOpacity(0.6),
                    // const Color.fromARGB(0, 255, 255, 255),
                    const Color.fromARGB(0, 255, 255, 255),
                  ],
                  stops: [0.0, 0.40, 5.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.60,
                  ),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_app.png',
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        'Sua fé.\nSeu caminho.',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: const Color.fromARGB(255, 43, 43, 43),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'Descubra o poder da fé em sua vida.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color.fromARGB(255, 43, 43, 43),
                        ),
                      ),
                      Text(
                        'Um espaço para você se conectar, refletir e crescer na sua caminhada com Deus.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color.fromARGB(255, 43, 43, 43),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 10);

    path.cubicTo(
      size.width * 0.25,
      size.height - 100, // CP1: 25% da largura, na base → curva desce
      size.width * 0.75,
      size.height, // CP2: 75% da largura, sobe 100px → curva sobe
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) => false;
}
